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
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/dns?ref=v1.0.1"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.stg_dns_records
  ns_delegation = {} # No subdomain delegation records yet
}

module "security" {
  source  = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/security?ref=v1.0.1"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

