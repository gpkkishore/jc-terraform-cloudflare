provider "cloudflare" {
  email      = var.account_email
  account_id = var.account_id
  api_key    = var.cloudflare_api_key
}

resource "cloudflare_zone" "cloudflare_zone_resource" {
  paused = false
  plan   = var.zone_plan
  type   = "full"
  zone   = var.zone_name
}

module "dns" {
  source             = "./modules/dns"
  zone_id            = cloudflare_zone.cloudflare_zone_resource.id
  awsstg_dns_records = var.awsstg_dns_records
  enable_awsstg      = var.enable_awsstg
  zone_name          = var.zone_name
  enable_nonprod     = var.enable_nonprod
}

module "security" {
  source  = "./modules/security"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

