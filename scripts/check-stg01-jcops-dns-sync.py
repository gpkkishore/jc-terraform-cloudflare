#!/usr/bin/env python3
"""Compare stg01.jcops.net app mirrors against expected proxied DNS sources.

Sources of truth for stg01.jumpcloud.com app hostnames:
  1. infra-edge/terraform/stg01/data_cdn.tf — CDN distributions (migrate_cname / proxied)
  2. stg01/data_stg01.tf — remaining proxied records still in terraform-cloudflare

Hand-maintained mirror: stg01/jcops.tf (local.jcops_app_dns_records)

Run from terraform-cloudflare repo root:
  python3 scripts/check-stg01-jcops-dns-sync.py

Optional env:
  INFRA_EDGE_DATA_CDN — path to data_cdn.tf (default: ../infra-edge/terraform/stg01/data_cdn.tf)
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
STG01_ZONE = "stg01.jumpcloud.com"
JCOPS_TF = REPO_ROOT / "stg01" / "jcops.tf"
DATA_STG01 = REPO_ROOT / "stg01" / "data_stg01.tf"
DEFAULT_DATA_CDN = REPO_ROOT.parent / "infra-edge" / "terraform" / "stg01" / "data_cdn.tf"


def parse_hcl_record_names(text: str, list_marker: str) -> set[str]:
    idx = text.find(list_marker)
    if idx < 0:
        raise ValueError(f"Could not find {list_marker!r}")
    chunk = text[idx:]
    depth = 0
    names: set[str] = set()
    for block in re.finditer(r"\{[^{}]*\}", chunk):
        body = block.group(0)
        if "proxied = true" not in body and list_marker != "jcops_app_dns_records":
            continue
        m = re.search(r'name\s*=\s*"([^"]+)"', body)
        if m:
            names.add(m.group(1))
    return names


def jcops_app_names() -> set[str]:
    text = JCOPS_TF.read_text()
    return parse_hcl_record_names(text, "jcops_app_dns_records = [")


def data_stg01_proxied_names() -> set[str]:
    text = DATA_STG01.read_text()
    names: set[str] = set()
    for block in re.finditer(r"\{[^{}]*\}", text):
        body = block.group(0)
        if re.search(r"^\s*#", body, re.M):
            continue
        if "proxied = true" not in body:
            continue
        m = re.search(r'name\s*=\s*"([^"]+)"', body)
        if m:
            names.add(m.group(1))
    return names


def fqdn_to_jcops_label(fqdn: str, zone: str) -> str | None:
    """Map brand-zone FQDN to jcops record name (e.g. api.stg01.jumpcloud.com -> api)."""
    suffix = f".{zone}"
    if not fqdn.endswith(suffix):
        return None
    label = fqdn[: -len(suffix)]
    # Cross-env vanity aliases on the brand zone are not mirrored as separate jcops names.
    if ".prd02" in label:
        return None
    # Test console CDN; not part of the production router mirror set.
    if label in ("tstconsole", "*.tstconsole"):
        return None
    return label


def data_cdn_stg01_labels(path: Path) -> set[str]:
    if not path.is_file():
        print(f"warning: data_cdn not found at {path}; skipping infra-edge source", file=sys.stderr)
        return set()

    text = path.read_text()
    labels: set[str] = set()
    zone = None
    domain_name = None
    aliases: list[str] = []

    def flush() -> None:
        nonlocal zone, domain_name, aliases
        if zone != STG01_ZONE:
            zone = domain_name = None
            aliases = []
            return
        if domain_name:
            label = fqdn_to_jcops_label(domain_name, STG01_ZONE)
            if label:
                labels.add(label)
        for alias in aliases:
            label = fqdn_to_jcops_label(alias, STG01_ZONE)
            if label:
                labels.add(label)
        zone = domain_name = None
        aliases = []

    for line in text.splitlines():
        m = re.search(r'zone\s*=\s*"([^"]+)"', line)
        if m:
            flush()
            zone = m.group(1)
        m = re.search(r'domain_name\s*=\s*"([^"]+)"', line)
        if m:
            domain_name = m.group(1)
        m = re.search(r"aliases\s*=\s*\[(.*)\]", line)
        if m:
            inner = m.group(1)
            aliases = re.findall(r'"([^"]+)"', inner)
    flush()
    return labels


def main() -> int:
    data_cdn_path = Path(
        __import__("os").environ.get("INFRA_EDGE_DATA_CDN", str(DEFAULT_DATA_CDN))
    )

    jcops = jcops_app_names()
    expected = data_stg01_proxied_names() | data_cdn_stg01_labels(data_cdn_path)

    missing = sorted(expected - jcops)
    extra = sorted(jcops - expected)

    print(f"jcops_app_dns_records: {len(jcops)} names")
    print(f"expected (data_stg01 proxied ∪ data_cdn {STG01_ZONE}): {len(expected)} names")

    if missing:
        print("\nMISSING from stg01/jcops.tf (add to jcops_app_dns_records):")
        for name in missing:
            print(f"  - {name}")

    if extra:
        print("\nEXTRA in jcops (not in either source; review if still required):")
        for name in extra:
            print(f"  - {name}")

    if missing:
        return 1
    print("\nOK: all expected proxied stg01 labels are mirrored in jcops.tf")
    return 0


if __name__ == "__main__":
    sys.exit(main())
