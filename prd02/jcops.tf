####################################################
# eu.jcops.net - Router Zone for EU (parallel to prd02.jumpcloud.com)
#
# Mirrors all proxied DNS entries from prd02.jumpcloud.com.
# Each proxied record points to the same prd02-euc1.jcplatform.dev origin.
#
# See: https://jumpcloud.atlassian.net/browse/TE-2005
####################################################

locals {
  jcops_zone_name = "eu.jcops.net"

  # Filter: only proxied records from the existing prd02 DNS data
  jcops_dns_records = [for r in local.prd02_dns_records : r if lookup(r, "proxied", false) == true]
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

module "jcops_security" {
  source                     = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.2.0"
  zone_id                    = cloudflare_zone.jcops_net.id
  additional_ratelimit_rules = []
  additional_waf_rules       = []
}

module "jcops_settings" {
  source           = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id          = cloudflare_zone.jcops_net.id
  always_use_https = "off"
}
