#!/usr/bin/env python3
"""Apply TE-2228 wildcard removals for a single terraform-cloudflare environment."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

DATA_FILES = {
    "stg01": ROOT / "stg01" / "data_stg01.tf",
    "prd": ROOT / "prd" / "data_prd.tf",
    "prd02": ROOT / "prd02" / "data.tf",
    "prd03": ROOT / "prd03" / "data.tf",
}

JCOPS_FILES = {
    "stg01": ROOT / "stg01" / "jcops.tf",
    "prd": ROOT / "prd" / "jcops.tf",
    "prd02": ROOT / "prd02" / "jcops.tf",
    "prd03": ROOT / "prd03" / "jcops.tf",
}

STATIC_DNS_REMOVE: dict[str, set[str]] = {
    "prd": {
        "*.adbridge",
        "*.adbridge-kickstart",
        "*.agent",
        "*.bss",
        "*.device-cert",
        "*.private-kickstart",
        "*.schema-registry",
        "*.search-api",
        "*.mcpv2",
        "*.nli",
        "*.polaris-console",
        "*.trino",
    },
    "prd02": {
        "*.adbridge",
        "*.adbridge-kickstart",
        "*.agent",
        "*.device-cert",
        "*.private-kickstart",
        "*.mcpv2",
        "*.nli",
        "*.polaris-console",
        "*.trino",
        "*.admin-oauth.id",
        "*.oauth.id",
        "*.trampoline.id",
    },
    "prd03": {
        "*.adbridge",
        "*.adbridge-kickstart",
        "*.agent",
        "*.device-cert",
        "*.private-kickstart",
        "*.schema-registry",
        "*.search-api",
    },
    "stg01": {
        "*.polaris-console",
        "*.schema-registry",
        "*.search-api",
        "*.trino",
        "*.tstconsole",
        "*.nli",
    },
}

JCOPS_WILDCARD_REMOVE: dict[str, set[str]] = {
    "stg01": {"*.nli"},
    "prd": {"*.nli", "*.polaris-console", "*.trino", "*.usermcp"},
    "prd02": {"*.polaris-console", "*.trino"},
    "prd03": {
        "*.admin-oauth.id",
        "*.usermcp",
        "*.oauth.id",
        "*.polaris-console",
        "*.trampoline.id",
        "*.trino",
    },
}

MOVE_KEYS: dict[str, set[str]] = {
    "prd02": {
        "*.admin-oauth.id",
        "*.oauth.id",
        "*.trampoline.id",
    },
}


def remove_dns_record_blocks(content: str, names: set[str]) -> str:
    for name in sorted(names, key=len, reverse=True):
        pattern = (
            rf"\n    \{{\n"
            rf'      name    = "{re.escape(name)}"\n'
            rf"(?:      [^\n]+\n)+?"
            rf"    \}},?"
        )
        content = re.sub(pattern, "", content)
    return content


def remove_moved_blocks_for_wildcards(content: str, names: set[str]) -> str:
    blocks = re.findall(r"moved \{\n(?:  [^\n]+\n)+\}\n", content)
    for block in blocks:
        if any(name.removeprefix("*.") in block for name in names):
            content = content.replace(block, "")
    return content


def apply_env(env: str) -> None:
    data_path = DATA_FILES[env]
    if data_path.exists() and STATIC_DNS_REMOVE.get(env):
        data_path.write_text(
            remove_dns_record_blocks(data_path.read_text(), STATIC_DNS_REMOVE[env])
        )

    jcops_path = JCOPS_FILES[env]
    if jcops_path.exists() and JCOPS_WILDCARD_REMOVE.get(env):
        jcops_path.write_text(
            remove_dns_record_blocks(jcops_path.read_text(), JCOPS_WILDCARD_REMOVE[env])
        )

    if env in MOVE_KEYS:
        move_path = ROOT / env / "move.tf"
        if move_path.exists():
            move_path.write_text(
                remove_moved_blocks_for_wildcards(move_path.read_text(), MOVE_KEYS[env])
            )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("env", choices=sorted(DATA_FILES))
    args = parser.parse_args()
    apply_env(args.env)
    print(f"Applied TE-2228 wildcard removals for {args.env}")


if __name__ == "__main__":
    main()
