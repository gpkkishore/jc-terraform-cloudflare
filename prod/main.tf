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
  source         = "./dns"
  zone_id        = cloudflare_zone.cloudflare_zone_resource.id
  zone_name      = var.zone_name
  mx_records     = local.prd_mx_records
  dns_records    = local.prd_dns_records
  ns_delegation  = local.prd_ns_delegation_records
  enable_noncore = var.enable_noncore
}

module "security" {
  source  = "./security"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

