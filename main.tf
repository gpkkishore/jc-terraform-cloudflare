provider "cloudflare" {
    email = var.account_email
    account_id = var.account_id
    api_key = var.cloudflare_api_key
}

resource "cloudflare_zone" "cloudflare_zone_resource" {
    paused = false
    plan   = var.zone_plan
    type   = "full"
    zone   = var.zone_name
}

module "dns" {
    source = "./modules/dns"
    zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

module "security" {
    source = "./modules/security"
    zone_id = cloudflare_zone.cloudflare_zone_resource.id
}
