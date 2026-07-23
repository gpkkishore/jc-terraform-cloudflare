####################################################
# jcops.net - Primary Router Zone (parallel to jumpcloud.com)
#
# Proxied brand rows still in prd/data_prd.tf → jcops_mirrored_dns_records.
# Retired brand proxied A (ai, staging, ti-1, ti-2) → jcops_app_dns_records (infra-edge owns brand CF).
# Vault / id child zones: separate mirror locals below.
#
# See: https://jumpcloud.atlassian.net/browse/TE-2005
# ST-02 (TE-2006): proxied * catch-all and routing-edge-fallback structural DNS.
# Zone Custom Hostnames fallback origin (prepares TE-2015); not Custom Hostname objects.
####################################################

locals {
  jcops_zone_name = "jcops.net"

  jcops_router_structural_dns_records = [
    {
      name    = "*"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud.com"
    },
    {
      name    = "routing-edge-fallback"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "status.jumpcloud.com"
    },
  ]

  # EU app labels (api.eu, etc.) live in eu.jcops.net as api — do not duplicate on parent jcops.net.
  prd_eu_jcops_record_names = toset([for r in local.prd_eu_records : r.name])

  # Explicit jcops.net origins for brand rows retired from prd_a_records (stg01/prd03 jcops_app_dns_records pattern).
  jcops_app_dns_records = [
    {
      name    = "ai"
      proxied = true
      ttl     = 1
      type    = "A"
      content = "35.241.16.49" # GCP LB prd — proxied-A custom origin for ai.jumpcloud.com CH
    },
    {
      name    = "staging"
      proxied = true
      ttl     = 1
      type    = "A"
      content = "32.194.81.196"
    },
    {
      name    = "ti-1"
      proxied = true
      ttl     = 1
      type    = "A"
      content = "44.239.47.105"
    },
    {
      name    = "ti-2"
      proxied = true
      ttl     = 1
      type    = "A"
      content = "52.13.15.220"
    },
  ]

  jcops_app_dns_record_names = toset([for r in local.jcops_app_dns_records : r.name])

  # Filter: only proxied app records from jumpcloud.com (exclude apex @; jcops.net is its own zone).
  jcops_mirrored_dns_records = [
    for r in local.prd_dns_records : r
    if lookup(r, "proxied", false) == true &&
    lookup(r, "name", "") != "@" &&
    !contains(local.jcops_app_dns_record_names, lookup(r, "name", "")) &&
    !contains(local.prd_eu_jcops_record_names, lookup(r, "name", ""))
  ]

  # Proxied vault.jumpcloud.com production rows → jcops.net (TE-2005).
  # Source list: data/vault_jcops_mirror_us.tf (parity-checked against prd/data_additional.tf).
  vault_jumpcloud_jcops_mirror_records = [
    for r in local.vault_jumpcloud_proxied_source_records : merge(r, {
      name = trimsuffix(
        replace(
          contains(["@", local.vault_jumpcloud_child_zone], r.name) ? local.vault_jumpcloud_child_zone : r.name,
          ".jumpcloud.com",
          ".jcops.net",
        ),
        ".${local.jcops_zone_name}",
      )
    })
  ]

  # id.jumpcloud.com: prd/id_jcops_mirror_us.tf (not in brand mirror).
  jcops_dns_records = concat(
    local.jcops_router_structural_dns_records,
    local.jcops_mirrored_dns_records,
    local.jcops_app_dns_records,
    local.vault_jumpcloud_jcops_mirror_records,
    local.id_jumpcloud_jcops_mirror_records,
  )

  jcops_add_waf_rules = concat(local.add_waf_rules["jumpcloud.com"], local.add_waf_rules["id.jumpcloud.com"], local.add_waf_rules["vault.jumpcloud.com"])

  jcops_add_ratelimit_rules = local.add_ratelimit_rules["jumpcloud.com"]
}

resource "cloudflare_zone" "jcops_net" {
  account_id = local.account_id
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
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=2.0.1"
  zone_id       = cloudflare_zone.jcops_net.id
  zone_name     = local.jcops_zone_name
  dns_records   = local.jcops_dns_records
  ns_delegation = local.jcops_child_ns_delegation_records
}

resource "cloudflare_custom_hostname_fallback_origin" "jcops_router" {
  zone_id = cloudflare_zone.jcops_net.id
  origin  = "routing-edge-fallback.${local.jcops_zone_name}"

  depends_on = [module.jcops_dns]
}

module "jcops_security" {
  source                     = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.6.0"
  zone_id                    = cloudflare_zone.jcops_net.id
  additional_ratelimit_rules = local.jcops_add_ratelimit_rules
  additional_waf_rules       = local.jcops_add_waf_rules
}

module "jcops_settings" {
  source           = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id          = cloudflare_zone.jcops_net.id
  always_use_https = "off"
}
