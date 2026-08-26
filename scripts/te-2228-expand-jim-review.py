#!/usr/bin/env python3
"""Expand TE-2228 Cloudflare mirror removals per James prd template."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

JIM_BASES = [
    "api",
    "apple-mdm",
    "assist",
    "console",
    "go",
    "kickstart",
    "login",
    "mcp",
    "oauth",
    "polaris",
    "saas",
    "slack",
    "sso",
]

ENV_CONFIG = {
    "stg01": {
        "jcops_names": {f"*.{b}" for b in JIM_BASES},
        "data_file": ROOT / "stg01" / "data_stg01.tf",
        "data_names": set(),
        "move_file": ROOT / "stg01" / "moved.tf",
        "custom_rules": ROOT / "stg01" / "custom_rules.tf",
        "cdn_suffix": "stg01.jumpcloud.com",
    },
    "prd02": {
        "jcops_names": {"*.polaris"},
        "data_file": ROOT / "prd02" / "data.tf",
        "data_names": {f"*.{b}" for b in JIM_BASES},
        "move_file": ROOT / "prd02" / "move.tf",
        "custom_rules": None,
        "cdn_suffix": "eu.jumpcloud.com",
    },
    "prd03": {
        "jcops_names": {f"*.{b}" for b in JIM_BASES},
        "data_file": ROOT / "prd03" / "data.tf",
        "data_names": set(),
        "move_file": ROOT / "prd03" / "move_jcops_cutover_brand.tf",
        "custom_rules": ROOT / "prd03" / "custom_rules.tf",
        "cdn_suffix": "in.jumpcloud.com",
    },
}


def remove_dns_blocks(content: str, names: set[str]) -> str:
    for name in sorted(names, key=len, reverse=True):
        pattern = (
            rf"\n    \{{\n"
            rf'      name    = "{re.escape(name)}"\n'
            rf"(?:      [^\n]+\n)+?"
            rf"    \}},?"
        )
        content = re.sub(pattern, "", content)
    return content


def remove_moved_for_labels(content: str, labels: set[str]) -> str:
    blocks = re.findall(r"moved \{\n(?:  [^\n]+\n)+\}\n", content)
    for block in blocks:
        for label in labels:
            if f"*.{label}_" in block or f"*.{label}." in block:
                content = content.replace(block, "")
                break
    return content


def strip_custom_rule_wildcards(content: str, bases: list[str], suffix: str) -> str:
    for base in bases:
        fq = f"*.{base}.{suffix}"
        content = content.replace(f'"{fq}",\n', "")
        content = content.replace(f'"{fq}, ', "")
        content = content.replace(f', "{fq}"', "")
    return content


def apply_env(env: str) -> None:
    cfg = ENV_CONFIG[env]
    labels = {n.removeprefix("*.") for n in cfg["jcops_names"] | cfg["data_names"]}

    jcops = ROOT / env / "jcops.tf"
    if cfg["jcops_names"]:
        jcops.write_text(remove_dns_blocks(jcops.read_text(), cfg["jcops_names"]))

    if cfg["data_names"] and cfg["data_file"].exists():
        cfg["data_file"].write_text(
            remove_dns_blocks(cfg["data_file"].read_text(), cfg["data_names"])
        )

    if cfg["move_file"].exists():
        cfg["move_file"].write_text(remove_moved_for_labels(cfg["move_file"].read_text(), labels))

    if cfg.get("custom_rules") and cfg["custom_rules"].exists():
        cfg["custom_rules"].write_text(
            strip_custom_rule_wildcards(
                cfg["custom_rules"].read_text(), list(JIM_BASES), cfg["cdn_suffix"]
            )
        )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("env", choices=sorted(ENV_CONFIG))
    args = parser.parse_args()
    apply_env(args.env)
    print(f"Applied Jim prd template mirror removals for {args.env}")


if __name__ == "__main__":
    main()
