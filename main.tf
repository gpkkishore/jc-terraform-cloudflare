provider "cloudflare" {
    email = var.account_email
    account_id = var.account_id
    api_key = var.cloudflare_api_key
}

resource "cloudflare_zone" "this" {
    zone = var.zone_name
}


module "dns" {
    source = "./modules/dns"
    zone_id = cloudflare_zone.this.id
}


module "security" {
    source = "./modules/security"
    zone_id = cloudflare_zone.this.id
}