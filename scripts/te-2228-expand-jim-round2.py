#!/usr/bin/env python3
"""Apply Jim's second-round wildcard review comments."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

PWM_BASES = ["grpc.pwm", "jumpdesk", "scim.pwm", "ssf"]

INFRA = {
    "prd02": {
        "cdn_suffix": "eu.jumpcloud.com",
        "static": {"*.grpc.pwm", "*.jumpdesk", "*.scim.pwm"},
        "failover_env": "prd02",
        "zone": "eu.jumpcloud.com",
    },
    "prd03": {
        "cdn_suffix": "in.jumpcloud.com",
        "static": set(),
        "failover_env": "prd03",
        "zone": "in.jumpcloud.com",
    },
}

TCF_STG01_STATIC = {
    "*.adbridge",
    "*.adbridge-kickstart",
    "*.bss",
    "*.device-cert",
    "*.private-kickstart",
    "*.agent",
    "*.grpc.pwm",
    "polaris-console",
}
TCF_STG01_JCOPS = {"ssf", "*.ssf", "password-manager", "*.password-manager"}
TCF_STG01_CUSTOM_EXACT = [
    "jumpdesk.stg01.jumpcloud.com",
    "catalog.stg01.jumpcloud.com",
    "password-manager.stg01.jumpcloud.com",
    "polaris-console.stg01.jumpcloud.com",
    "scim-bridge.stg01.jumpcloud.com",
    "trino.stg01.jumpcloud.com",
    "search-api.stg01.jumpcloud.com",
    "ssf.stg01.jumpcloud.com",
]
TCF_STG01_CUSTOM_WILD = [
    "*.jumpdesk.stg01.jumpcloud.com",
    "*.catalog.stg01.jumpcloud.com",
    "*.password-manager.stg01.jumpcloud.com",
    "*.polaris-console.stg01.jumpcloud.com",
    "*.scim-bridge.stg01.jumpcloud.com",
    "*.ssf.stg01.jumpcloud.com",
    "*.search-api.stg01.jumpcloud.com",
    "*.trino.stg01.jumpcloud.com",
]


def remove_dns_blocks(content: str, names: set[str], flexible: bool = False) -> str:
    for name in sorted(names, key=len, reverse=True):
        if flexible or not name.startswith("*."):
            pattern = (
                rf"\n    \{{\n"
                rf'      name    = "{re.escape(name)}"\n'
                rf"(?:      [^\n]+\n)+?"
                rf"    \}},?"
            )
        else:
            pattern = (
                rf"\n    \{{\n"
                rf'      name    = "{re.escape(name)}"\n'
                rf"      type    = \"CNAME\"\n"
                rf"      content = \"[^\"]+\"\n"
                rf"      ttl     = \d+\n"
                rf"    \}},?"
            )
        content = re.sub(pattern, "", content)
    return content


def clear_cdn_aliases(content: str, aliases: list[str]) -> str:
    for alias in aliases:
        content = content.replace(f'aliases       = ["{alias}"]', "aliases       = []")
    return content


def remove_moved_labels(content: str, labels: set[str]) -> str:
    blocks = re.findall(r"moved \{\n(?:  [^\n]+\n)+\}\n", content)
    for block in blocks:
        for label in labels:
            if f"*.{label}_CNAME" in block or f"{label}_CNAME" in block:
                content = content.replace(block, "")
                break
    return content


def strip_list_entries(content: str, entries: list[str]) -> str:
    for entry in entries:
        content = re.sub(rf'^\s*"{re.escape(entry)}",\n', "", content, flags=re.M)
        content = re.sub(rf',\s*"{re.escape(entry)}"', "", content)
    return content


def apply_infra(env: str) -> None:
    cfg = INFRA[env]
    labels = {b for b in PWM_BASES}
    aliases = [f"*.{b}.{cfg['cdn_suffix']}" for b in PWM_BASES]

    env_root = ROOT / "terraform" / env
    if cfg["static"]:
        dns = env_root / "data_dns_route53_records.tf"
        dns.write_text(remove_dns_blocks(dns.read_text(), cfg["static"]))

    cdn = env_root / "data_cdn.tf"
    cdn.write_text(clear_cdn_aliases(cdn.read_text(), aliases))

    for moved in env_root.glob("route53_*_moved.tf"):
        moved.write_text(remove_moved_labels(moved.read_text(), labels))

    failover = ROOT / "scripts" / "failover" / "failover-config.json"
    data = json.loads(failover.read_text())
    remove_names = set(aliases)
    for zone in data["environments"][cfg["failover_env"]]["zones"]:
        if zone.get("hosted_zone_name") == cfg["zone"]:
            zone["weighted_records"] = [
                r for r in zone.get("weighted_records", []) if r.get("name") not in remove_names
            ]
    failover.write_text(json.dumps(data, indent=2) + "\n")


def apply_tcf_stg01() -> None:
    tcf = ROOT
    data = tcf / "stg01" / "data_stg01.tf"
    data.write_text(remove_dns_blocks(data.read_text(), TCF_STG01_STATIC, flexible=True))

    jcops = tcf / "stg01" / "jcops.tf"
    jcops.write_text(remove_dns_blocks(jcops.read_text(), TCF_STG01_JCOPS, flexible=True))

    cr = tcf / "stg01" / "custom_rules.tf"
    text = cr.read_text()
    text = strip_list_entries(text, TCF_STG01_CUSTOM_EXACT + TCF_STG01_CUSTOM_WILD)
    cr.write_text(text)


def apply_tcf_pwm(env: str) -> None:
    suffix = "eu.jumpcloud.com" if env == "prd02" else "in.jumpcloud.com"
    static = {f"*.{b}" for b in PWM_BASES}
    labels = set(PWM_BASES)

    data = ROOT / env / "data.tf"
    if data.exists():
        data.write_text(remove_dns_blocks(data.read_text(), static, flexible=True))

    jcops = ROOT / env / "jcops.tf"
    if jcops.exists():
        jcops.write_text(remove_dns_blocks(jcops.read_text(), static, flexible=True))

    move = ROOT / env / "move.tf"
    if move.exists():
        move.write_text(remove_moved_labels(move.read_text(), labels))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("target", choices=["infra-prd02", "infra-prd03", "tcf-stg01", "tcf-prd02", "tcf-prd03"])
    args = parser.parse_args()
    if args.target == "infra-prd02":
        apply_infra("prd02")
    elif args.target == "infra-prd03":
        apply_infra("prd03")
    elif args.target == "tcf-stg01":
        apply_tcf_stg01()
    elif args.target == "tcf-prd02":
        apply_tcf_pwm("prd02")
    elif args.target == "tcf-prd03":
        apply_tcf_pwm("prd03")
    print(f"Applied Jim round-2 removals: {args.target}")


if __name__ == "__main__":
    main()
