#!/usr/bin/env python3
"""Verify vault jcops mirror source records match prd vault_*_records (proxied)."""

from __future__ import annotations

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]


def normalize_name(name: str, child_zone: str) -> str:
    normalized = name.strip().strip('"').rstrip(".").lower()
    zone = child_zone.rstrip(".").lower()
    if normalized in {"@", zone}:
        return zone
    if normalized.endswith(".jumpcloud.com"):
        return normalized
    return f"{normalized}.{zone}"


def parse_proxied_records(tf_text: str, child_zone: str) -> list[tuple[str, str, str]]:
    records: list[tuple[str, str, str]] = []
    for block in re.finditer(r"\{[^{}]*\}", tf_text, flags=re.DOTALL):
        chunk = block.group(0)
        if "proxied = true" not in chunk:
            continue
        name_match = re.search(r'name\s*=\s*"([^"]+)"', chunk)
        type_match = re.search(r"type\s*=\s*\"([^\"]+)\"", chunk)
        target_match = re.search(
            r"(?:content|value)\s*=\s*\"([^\"]+)\"",
            chunk,
        )
        if not (name_match and type_match and target_match):
            continue
        name = normalize_name(name_match.group(1), child_zone)
        record_type = type_match.group(1).upper()
        target = target_match.group(1).rstrip(".").lower()
        records.append((name, record_type, target))
    return sorted(records)


def load_tf(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def compare_region(
    region: str,
    child_zone: str,
    additional_var: str,
    mirror_path: Path,
) -> list[str]:
    additional_text = load_tf(REPO_ROOT / "prd" / "data_additional.tf")
    var_match = re.search(
        rf"{re.escape(additional_var)}\s*=\s*\[(.*?)\n  \]",
        additional_text,
        flags=re.DOTALL,
    )
    if not var_match:
        return [f"{region}: could not find {additional_var} in prd/data_additional.tf"]

    prd_records = parse_proxied_records(var_match.group(1), child_zone)
    mirror_records = parse_proxied_records(load_tf(mirror_path), child_zone)
    errors: list[str] = []
    if prd_records != mirror_records:
        prd_set = set(prd_records)
        mirror_set = set(mirror_records)
        for missing in sorted(prd_set - mirror_set):
            errors.append(f"{region}: missing in {mirror_path.name}: {missing}")
        for extra in sorted(mirror_set - prd_set):
            errors.append(f"{region}: extra in {mirror_path.name}: {extra}")
    return errors


def main() -> int:
    checks = [
        (
            "eu",
            "vault.eu.jumpcloud.com",
            "vault_eu_records",
            REPO_ROOT / "data" / "vault_jcops_mirror_eu.tf",
        ),
        (
            "in",
            "vault.in.jumpcloud.com",
            "vault_in_records",
            REPO_ROOT / "data" / "vault_jcops_mirror_in.tf",
        ),
    ]
    errors: list[str] = []
    for region, child_zone, additional_var, mirror_path in checks:
        errors.extend(compare_region(region, child_zone, additional_var, mirror_path))

    if errors:
        print("vault jcops mirror parity check failed:", file=sys.stderr)
        for error in errors:
            print(f"  - {error}", file=sys.stderr)
        return 1

    print("vault jcops mirror parity check passed (eu + in)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
