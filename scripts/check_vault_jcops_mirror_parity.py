#!/usr/bin/env python3
"""Verify vault jcops mirror source records match prd vault_*_records (proxied)."""

from __future__ import annotations

import sys
from collections import Counter
from pathlib import Path

try:
    import hcl2
except ImportError:  # pragma: no cover - runtime dependency check
    print(
        "python-hcl2 is required: pip install python-hcl2",
        file=sys.stderr,
    )
    raise SystemExit(1) from None

REPO_ROOT = Path(__file__).resolve().parents[1]
RecordTuple = tuple[str, str, str]
VAULT_NONPROD_MARKERS = (".dev.vault.", ".stg.vault.", ".homolog.vault.")
VAULT_NONPROD_PREFIXES = ("dev.vault.", "stg.vault.", "homolog.vault.")

# Brand-zone orange CNAMEs for these FQDNs moved to infra-edge (prd03 cutover).
# jcops mirror lists remain the source of truth for router-side orange origins.
IN_MIRROR_ONLY_FQDNS = frozenset(
    {
        "api.vault.in.jumpcloud.com",
        "app.vault.in.jumpcloud.com",
        "ws.vault.in.jumpcloud.com",
        "*.api.vault.in.jumpcloud.com",
        "*.app.vault.in.jumpcloud.com",
        "*.ws.vault.in.jumpcloud.com",
    }
)


def is_production_vault_fqdn(fqdn: str) -> bool:
    normalized = fqdn.rstrip(".").lower()
    if any(normalized.startswith(prefix) for prefix in VAULT_NONPROD_PREFIXES):
        return False
    return not any(marker in normalized for marker in VAULT_NONPROD_MARKERS)


def hcl_string(value: object) -> str:
    return str(value).strip().strip('"').strip("'").rstrip(".")


def record_label(name: str) -> str:
    return name or "<unknown>"


def normalize_name(name: str, child_zone: str) -> str:
    normalized = name.rstrip(".").lower()
    zone = child_zone.rstrip(".").lower()
    if normalized in {"@", zone}:
        return zone
    if normalized.endswith(".jumpcloud.com"):
        return normalized
    return f"{normalized}.{zone}"


def load_locals(path: Path) -> dict[str, object]:
    with path.open(encoding="utf-8") as handle:
        parsed = hcl2.load(handle)
    merged: dict[str, object] = {}
    for block in parsed.get("locals", []):
        if not isinstance(block, dict):
            raise ValueError(f"{path}: locals block is not a mapping")
        merged.update(block)
    return merged


def record_tuple(record: dict[str, object], child_zone: str) -> RecordTuple:
    name = normalize_name(hcl_string(record.get("name", "")), child_zone)
    record_type = hcl_string(record.get("type", "")).upper()
    target_key = "content" if "content" in record else "value"
    if target_key not in record:
        raise ValueError(f"{record_label(name)}: missing content/value target")
    target = hcl_string(record[target_key]).lower()
    if not name or not record_type or not target:
        raise ValueError(f"{record_label(name)}: incomplete proxied record")
    return name, record_type, target


def proxied_records_from_locals(
    locals_data: dict[str, object],
    list_key: str,
    child_zone: str,
    source_label: str,
    *,
    production_only: bool = False,
) -> list[RecordTuple]:
    raw_records = locals_data.get(list_key)
    if not isinstance(raw_records, list):
        raise ValueError(f"{source_label}: missing list {list_key}")

    records: list[RecordTuple] = []
    for index, raw_record in enumerate(raw_records):
        if not isinstance(raw_record, dict):
            raise ValueError(f"{source_label}: record {index} in {list_key} is not a mapping")
        if raw_record.get("proxied") is not True:
            continue
        try:
            record = record_tuple(raw_record, child_zone)
        except ValueError as exc:
            raise ValueError(f"{source_label}: {list_key}[{index}]: {exc}") from exc
        if production_only and not is_production_vault_fqdn(record[0]):
            continue
        records.append(record)
    return sorted(records)


def compare_region(
    region: str,
    child_zone: str,
    additional_var: str,
    mirror_list_key: str,
    mirror_path: Path,
    *,
    production_only: bool = False,
    mirror_only_fqdns: frozenset[str] | None = None,
) -> list[str]:
    prd_locals = load_locals(REPO_ROOT / "prd" / "data_additional.tf")
    mirror_locals = load_locals(mirror_path)
    prd_records = proxied_records_from_locals(
        prd_locals,
        additional_var,
        child_zone,
        "prd/data_additional.tf",
        production_only=production_only,
    )
    mirror_records = proxied_records_from_locals(
        mirror_locals,
        mirror_list_key,
        child_zone,
        str(mirror_path.relative_to(REPO_ROOT)),
    )

    errors: list[str] = []
    prd_counts = Counter(prd_records)
    mirror_counts = Counter(mirror_records)
    allowed_mirror_only = mirror_only_fqdns or frozenset()
    if prd_counts != mirror_counts:
        for key in sorted(set(prd_counts) | set(mirror_counts)):
            diff = prd_counts[key] - mirror_counts[key]
            if diff > 0:
                errors.append(
                    f"{region}: missing {diff} in {mirror_path.name}: {key}"
                )
            elif diff < 0:
                # Mirror-only rows after brand orange retire (infra-edge owns brand DNS).
                if key[0] in allowed_mirror_only and prd_counts[key] == 0:
                    continue
                errors.append(
                    f"{region}: extra {-diff} in {mirror_path.name}: {key}"
                )
    return errors


def main() -> int:
    checks = [
        (
            "us",
            "vault.jumpcloud.com",
            "vault_records",
            "vault_jumpcloud_proxied_source_records",
            REPO_ROOT / "data" / "vault_jcops_mirror_us.tf",
            True,
            None,
        ),
        (
            "eu",
            "vault.eu.jumpcloud.com",
            "vault_eu_records",
            "vault_eu_proxied_source_records",
            REPO_ROOT / "data" / "vault_jcops_mirror_eu.tf",
            False,
            None,
        ),
        (
            "in",
            "vault.in.jumpcloud.com",
            "vault_in_records",
            "vault_in_proxied_source_records",
            REPO_ROOT / "data" / "vault_jcops_mirror_in.tf",
            False,
            IN_MIRROR_ONLY_FQDNS,
        ),
    ]
    errors: list[str] = []
    for (
        region,
        child_zone,
        additional_var,
        mirror_list_key,
        mirror_path,
        production_only,
        mirror_only_fqdns,
    ) in checks:
        try:
            errors.extend(
                compare_region(
                    region,
                    child_zone,
                    additional_var,
                    mirror_list_key,
                    mirror_path,
                    production_only=production_only,
                    mirror_only_fqdns=mirror_only_fqdns,
                )
            )
        except (ValueError, OSError) as exc:
            errors.append(f"{region}: {exc}")

    if errors:
        print("vault jcops mirror parity check failed:", file=sys.stderr)
        for error in errors:
            print(f"  - {error}", file=sys.stderr)
        return 1

    print("vault jcops mirror parity check passed (us + eu + in)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
