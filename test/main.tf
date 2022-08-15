provider "cloudflare" {
  api_token    = var.cloudflare_api_token
}

resource "cloudflare_zone" "cloudflare_zone_resource" {
  paused = false
  plan   = var.zone_plan
  type   = "full"
  zone   = var.zone_name
}

module "dns" {
  source        = "../modules/dns"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  mx_records    = local.tst_mx_records
  dns_records   = local.tst_dns_records
  ns_delegation = local.tst_ns_delegation_records
}

module "security" {
  source  = "../modules/security"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

