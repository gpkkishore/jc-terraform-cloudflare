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

module "dns" {
  source         = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/dns?ref=v1.0.1"
  zone_id        = cloudflare_zone.cloudflare_zone_resource.id
  zone_name      = var.zone_name
  dns_records    = local.prd_dns_records
  ns_delegation  = local.prd_ns_delegation_records
  enable_noncore = var.enable_noncore
}

module "security" {
  source  = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/security?ref=v1.0.1"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}
