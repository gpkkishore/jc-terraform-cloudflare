####################################################
# eu.jcops.net - Router Zone for EU (parallel to prd02.jumpcloud.com)
#
# Mirrors all proxied DNS entries from prd02.jumpcloud.com.
# Each proxied record points to the same prd02-euc1.jcplatform.dev origin.
#
# Brand cutover (api.eu.jumpcloud.com on parent jumpcloud.com) is separate:
# retiring oranges from prd/data_prd.tf prd_eu_records does NOT shrink this
# mirror set — eu.jcops.net still feeds from prd02_dns_records (+ supplements).
#
# See: https://jumpcloud.atlassian.net/browse/TE-2005
# ST-02 (TE-2006): proxied * catch-all and routing-edge-fallback structural DNS.
# Zone Custom Hostnames fallback origin (prepares TE-2015); not Custom Hostname objects.
####################################################

locals {
  jcops_zone_name = "eu.jcops.net"

  jcops_router_structural_dns_records = [
    {
      name    = "*"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpcloud.com"
    },
    {
      name    = "routing-edge-fallback"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "status.jumpcloud.com"
    },
  ]

  # Filter: proxied prd02 zone records, plus parent-zone EU labels (e.g. ai.eu) excluded from jcops.net.
  prd02_proxied_jcops_mirrors = [for r in local.prd02_dns_records : r if lookup(r, "proxied", false) == true]
  prd02_proxied_jcops_names   = toset([for r in local.prd02_proxied_jcops_mirrors : r.name])

  # Parent-zone EU labels on jumpcloud.com (e.g. polaris.eu) are not in prd02_dns_records,
  # so they are not auto-mirrored. Warm R53 already CNAMEs those hosts to <label>.eu.jcops.net;
  # without these rows the router path hits the structural * catch-all.
  # Source: prd/data_prd.tf EU labels (TE-2074); polaris/trino/scep removed from prd02 in #860.
  jcops_eu_parent_zone_supplement = [
    {
      name    = "ai"
      proxied = true
      ttl     = 1
      type    = "A"
      content = "34.120.238.176"
    },
    {
      name    = "polaris"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "polaris.prd02-euc1.jcplatform.dev"
    },
    {
      name    = "polaris-console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "polaris-console.prd02-euc1.jcplatform.dev"
    },
    {
      name    = "trino"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "trino.prd02-euc1.jcplatform.dev"
    },
    {
      name    = "scep"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "ocsp.prd02-euc1.jcplatform.dev"
    },
    {
      name    = "ssf"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd02-euc1.jcplatform.dev"
    },
  ]

  # Proxied vault.eu child-zone rows → eu.jcops.net (TE-2005).
  # Source list: data/vault_jcops_mirror_eu.tf (parity-checked against prd/data_additional.tf).
  vault_eu_jcops_mirror_records = [
    for r in local.vault_eu_proxied_source_records : merge(r, {
      name = trimsuffix(
        replace(
          r.name == "@" ? local.vault_eu_child_zone : r.name,
          ".jumpcloud.com",
          ".jcops.net",
        ),
        ".${local.jcops_zone_name}",
      )
    })
  ]

  jcops_dns_records = concat(
    local.jcops_router_structural_dns_records,
    local.prd02_proxied_jcops_mirrors,
    [for r in local.jcops_eu_parent_zone_supplement : r if !contains(local.prd02_proxied_jcops_names, r.name)],
    local.vault_eu_jcops_mirror_records,
  )
}

resource "cloudflare_zone" "jcops_net" {
  account_id = local.cloudflare_account
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = local.jcops_zone_name
}

resource "cloudflare_total_tls" "jcops_net" {
  zone_id               = cloudflare_zone.jcops_net.id
  enabled               = true
  certificate_authority = "lets_encrypt"
}

module "jcops_dns" {
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=3.0.0"
  zone_id       = cloudflare_zone.jcops_net.id
  zone_name     = local.jcops_zone_name
  dns_records   = local.jcops_dns_records
  ns_delegation = []
}

resource "cloudflare_custom_hostname_fallback_origin" "jcops_router" {
  zone_id = cloudflare_zone.jcops_net.id
  origin  = "routing-edge-fallback.${local.jcops_zone_name}"

  depends_on = [module.jcops_dns]
}

module "jcops_security" {
  source                     = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.2.0"
  zone_id                    = cloudflare_zone.jcops_net.id
  additional_ratelimit_rules = concat(local.eu_jcops_add_ratelimit_rules, local.vault_istenantavailable_ratelimit_rules) # TE-2401: vault.eu mirrored here
  additional_waf_rules       = concat(local.cve_2026_111497_waf_rules, local.eu_jcops_add_waf_rules)
}

module "jcops_settings" {
  source           = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id          = cloudflare_zone.jcops_net.id
  always_use_https = "off"
}
