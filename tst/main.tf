resource "cloudflare_zone" "cloudflare_zone_resource" {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = var.cloudflare_account_id
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

module "dns" {
  source        = "app.terraform.io/jumpcloud/dns/cloudflare"
  version       = "2.0.1"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.tst_dns_records
  ns_delegation = local.tst_ns_delegation_records
}

module "security" {
  source  = "app.terraform.io/jumpcloud/security/cloudflare"
  version = "3.0.1"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

module "settings" {
  source  = "app.terraform.io/jumpcloud/zone-settings/cloudflare"
  version = "2.0.1"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}
