locals {
  aws_account = "330105897241"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = "us-east-2"

  assume_role {
    role_arn = format("arn:aws:iam::%s:role/terraform-admin", local.aws_account)
  }

  default_tags {
    Source      = format("TheJumpCloud/terraform-cloudflare/%s", var.env)
    Team        = "edge"
    CostOrg     = "engineering"
    ProductLine = "shared"
    Env         = var.env
  }
}

resource "cloudflare_zone" "cloudflare_zone_resource" {
  plan = var.zone_plan
  type = "full"
  zone = var.zone_name
}

module "dns" {
  source        = "app.terraform.io/jumpcloud/dns/cloudflare"
  version       = "1.0.6"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.stg01_dns_records
  ns_delegation = local.stg01_ns_delegation_records
}

module "security" {
  source  = "app.terraform.io/jumpcloud/security/cloudflare"
  version = "1.0.8"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

module "settings" {
  source  = "app.terraform.io/jumpcloud/zone-settings/cloudflare"
  version = "1.0.3"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

resource "aws_route53_zone" "r53_delegated_zone" {
  for_each = toset(local.r53_zones)
  name     = each.key
}

# Page rules for console.{zone_name}/*, e.g. console.jumpcloud.com/*
# Note: Browser check is disabled for the console endpoint only on awsstg so acceptance tests don't get blocked
resource "cloudflare_page_rule" "console_api_page_rule" {
  zone_id  = cloudflare_zone.cloudflare_zone_resource.id
  target   = "*console.${var.zone_name}/*"
  priority = 1

  actions {
    # Turn off Browser Integrity Check for /api requests
    browser_check = "off"
  }
}
