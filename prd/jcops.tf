####################################################
# jcops.net - Primary Router Zone (parallel to jumpcloud.com)
#
# This zone mirrors all proxied DNS entries from jumpcloud.com.
# Each proxied record points to the same jcplatform.dev origin.
# Non-proxied records are NOT included (they go to AWS Route 53).
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

  # Filter: only proxied app records from jumpcloud.com (exclude apex @; jcops.net is its own zone).
  jcops_mirrored_dns_records = [
    for r in local.prd_dns_records : r
    if lookup(r, "proxied", false) == true && lookup(r, "name", "") != "@" && !contains(local.prd_eu_jcops_record_names, lookup(r, "name", ""))
  ]

  jcops_dns_records = concat(
    local.jcops_router_structural_dns_records,
    local.jcops_mirrored_dns_records
  )
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
  additional_ratelimit_rules = []
  additional_waf_rules       = []
}

module "jcops_settings" {
  source           = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id          = cloudflare_zone.jcops_net.id
  always_use_https = "off"
}
