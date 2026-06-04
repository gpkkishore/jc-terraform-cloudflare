# stg01.jcops.net app DNS mirror maintenance

`prd`, `prd02`, and `prd03` jcops zones **mirror proxied records dynamically** from each env’s `*_dns_records` locals.

**stg01 is different:** `stg01/jcops.tf` uses a **hand-maintained** `jcops_app_dns_records` list because most staging app DNS now lives in **infra-edge** (`cdn-ng` / CloudFront), not in `stg01/data_stg01.tf`.

## Two sources of truth (stg01.jumpcloud.com)

| Source | Path | What it owns |
|--------|------|----------------|
| **infra-edge** | `infra-edge/terraform/stg01/data_cdn.tf` | Proxied CDN CNAMEs for apps on `stg01.jumpcloud.com` (`migrate_cname = true`) |
| **terraform-cloudflare** | `stg01/data_stg01.tf` | Any **remaining** proxied records still defined here (e.g. `polaris`, `scep`, `ocsp`) |

Structural router records (`*`, `routing-edge-fallback`) and zone fallback origin are defined only in `stg01/jcops.tf`.

## Guardrail

From `terraform-cloudflare` repo root:

```bash
python3 scripts/check-stg01-jcops-dns-sync.py
```

The script unions expected labels from both sources and fails if `jcops_app_dns_records` is missing any. “Extra” jcops names are reported for manual review (e.g. legacy `saas`).

Set `INFRA_EDGE_DATA_CDN` if `infra-edge` is not a sibling of this repo.

## When to update jcops.tf

- New app added to `data_cdn.tf` for `stg01.jumpcloud.com`
- New or re-enabled proxied record in `data_stg01.tf`
- After Bugbot or review flags a gap (e.g. polaris / scep)

## Related tickets

- TE-2005 / ST-01 — router zones ([PR 840](https://github.com/TheJumpCloud/terraform-cloudflare/pull/840))
- ST-02 — `*` catch-all and `routing-edge-fallback` (TE-2006)
- Zone fallback origin — owned here; **not** in `cdn-ng` (`fallback_origin.manage = false` on router zones per TE-2007)
