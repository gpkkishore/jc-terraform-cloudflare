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
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/dns?ref=v1.0.0"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  mx_records    = local.stg_mx_records
  dns_records   = var.enable_awsstg ? local.stg_dns_records : {}
  ns_delegation = local.stg_ns_delegation_records
}

module "security" {
  source  = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/security?ref=v1.0.0"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

