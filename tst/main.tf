provider "cloudflare" {
  api_token    = var.cloudflare_api_token
}

resource "cloudflare_zone" "cloudflare_zone_resource" {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = "3c96d914c0eaa62b7b4c9960e63818f7"
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

# Customizes Cloudflare zone settings, defaults if not explicitly set
resource "cloudflare_zone_settings_override" "tst_zone_settings_override" {
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
  settings {
    always_use_https         = "on"
    automatic_https_rewrites = "on"
  }
}

module "dns" {
  source         = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/dns?ref=v1.0.1"
  zone_id        = cloudflare_zone.cloudflare_zone_resource.id
  zone_name      = var.zone_name
  dns_records    = local.tst_dns_records
  ns_delegation  = local.tst_ns_delegation_records
  enable_noncore = var.enable_noncore
}

module "security" {
  source  = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/security?ref=v1.0.1"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}
