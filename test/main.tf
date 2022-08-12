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
  dns_records   = local.prd_dns_records
  ns_delegation = local.prd_ns_delegation_records
}

module "security" {
  source  = "../modules/security"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

