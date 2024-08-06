resource "cloudflare_zone" "cloudflare_zone_resource" {
  account_id = local.cloudflare_account
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

module "dns" {
  source        = "app.terraform.io/jumpcloud/dns/cloudflare"
  version       = "2.0.1"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.prd02_dns_records
  ns_delegation = local.prd02_ns_delegation_records
}

module "security" {
  source  = "app.terraform.io/jumpcloud/security/cloudflare"
  version = "3.0.1"

  zone_id                    = cloudflare_zone.cloudflare_zone_resource.id
  additional_ratelimit_rules = local.add_ratelimit_rules
  additional_waf_rules       = local.add_waf_rules
}

module "settings" {
  source  = "app.terraform.io/jumpcloud/zone-settings/cloudflare"
  version = "2.0.2"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}
