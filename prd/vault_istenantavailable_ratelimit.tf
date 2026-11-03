# IR-200 / FIND-007: Vault tenant enumeration via IsTenantAvailable
# Jira: TE-2401 (PPB-1653, SEC-11490) | Slack: #ir-200-slate-otter-vault-tenant-enum
#
# Per-IP rate limits on the unauthenticated ABP endpoint
# /api/services/app/Account/IsTenantAvailable. The app layer also rate-limits this endpoint;
# these rules are the edge enforcement Security asked for. They do not apply if traffic fails
# over to CloudFront (Edge Redundancy), so keep the app-layer limit as a backstop.
#
# Cloudflare has no memory of past offenses, so "progressive" blocking is approximated with two
# stacked rules (agreed with Security / Noah Syens):
#   1. Persistent: 300 req / 1h per IP -> block 1 day
#   2. Base:        30 req / 1m per IP -> block 1 hour
#
# ORDER MATTERS: Block is terminating. The persistent rule must be evaluated BEFORE the base rule,
# otherwise requests blocked by the base rule never reach the persistent rule's counter and
# repeat offenders never escalate.
#
# Path match is case-insensitive (ABP routes are) and any method, so case/method variants
# can't bypass it.
#
# Rollout: ship as "log", soak and review would-be blocks in Security Analytics, then set
# vault_istenantavailable_action = "block".
#
# Identical copies live in prd/, prd02/ and prd03/ (one per workspace). Keep them in sync.
locals {
  vault_istenantavailable_action = "log"

  vault_istenantavailable_expression = "(lower(http.request.uri.path) in {\"/api/services/app/account/istenantavailable\" \"/api/services/app/account/istenantavailable/\"} and http.host matches r\"(^|\\.)vault\\.((eu|in)\\.)?(jumpcloud\\.com|jcops\\.net)$\")"

  vault_istenantavailable_zones = [
    "vault.jumpcloud.com",
    "vault.eu.jumpcloud.com",
    "vault.in.jumpcloud.com",
  ]

  vault_istenantavailable_ratelimit_rules = [
    {
      action      = local.vault_istenantavailable_action
      description = "TE-2401 / IR-200 - Vault IsTenantAvailable persistent per-IP limit (300/1h, block 1d)"
      expression  = local.vault_istenantavailable_expression

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        mitigation_timeout  = 86400
        period              = 3600
        requests_per_period = 300
      }
    },
    {
      action      = local.vault_istenantavailable_action
      description = "TE-2401 / IR-200 - Vault IsTenantAvailable base per-IP limit (30/1m, block 1h)"
      expression  = local.vault_istenantavailable_expression

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        mitigation_timeout  = 3600
        period              = 60
        requests_per_period = 30
      }
    },
  ]
}
