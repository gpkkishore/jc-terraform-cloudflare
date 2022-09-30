locals {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = "3c96d914c0eaa62b7b4c9960e63818f7"

  # All Cloudflare zones ids
  cloudflare_zone_all_ids = concat([cloudflare_zone.cloudflare_zone_resource.id], [for zone in cloudflare_zone.additional_zone : zone.id])
}

resource "cloudflare_zone" "cloudflare_zone_resource" {
  account_id = local.account_id
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

# This resource allows for the creation of additional zones that may not necessarily have their own workspace or are managed in other repos.
# This allows us to centralize zone creation to one repo and limit permission scope on tokens
resource "cloudflare_zone" "additional_zone" {
  for_each   = toset(local.cloudflare_zones)
  account_id = local.account_id
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = each.key
}

module "dns" {
  source         = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/dns?ref=v1.1.2"
  zone_id        = cloudflare_zone.cloudflare_zone_resource.id
  zone_name      = var.zone_name
  dns_records    = local.prd_dns_records
  ns_delegation  = local.prd_ns_delegation_records
  enable_noncore = var.enable_noncore
}

module "security" {
  for_each = toset(local.cloudflare_zone_all_ids)
  source   = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/security?ref=v1.0.1"
  zone_id  = each.key
}

module "settings" {
  for_each = toset(local.cloudflare_zone_all_ids)
  source   = "../modules/settings"
  zone_id  = each.key
}

# Page rules for console.{zone_name}/api*, e.g. console.jumpcloud.com/api*
resource "cloudflare_page_rule" "console_api_page_rule" {
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
  target = "*console.${var.zone_name}/api*"
  priority = 1

  actions {
    # Turn off Browser Integrity Check for /api requests
    browser_check = "off"
  }
}
