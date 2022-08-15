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
  mx_records    = local.tst_mx_records
  dns_records   = local.tst_dns_records
  ns_delegation = local.tst_ns_delegation_records
  enable_noncore = var.enable_noncore
}

module "security" {
  source  = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/security?ref=v1.0.0"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

