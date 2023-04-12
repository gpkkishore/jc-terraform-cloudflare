provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::712689858297:role/RootAccountAdminAccess"
  }
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
  source        = "app.terraform.io/jumpcloud/dns/cloudflare"
  version       = "1.0.6"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.stg_dns_records
  ns_delegation = local.stg_ns_delegation_records
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

module "tags" {
  source     = "git@github.com:TheJumpCloud/terraform-modules//internal/default_tags?ref=v6.4.7"
  env_prefix = var.env
  project    = var.project_name
  managed_by = terraform.workspace
}

resource "aws_route53_zone" "r53_delegated_zone" {
  for_each = toset(local.r53_zones)
  name     = each.key

  tags = module.tags.default_tags
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

# apple.mdm advanced certificate manager for Let's Encrypt
resource "cloudflare_certificate_pack" "custom_cert" {
  for_each = { for cert in local.custom_certs : cert.name => cert }

  zone_id                = cloudflare_zone.cloudflare_zone_resource.id
  type                   = "advanced"
  hosts                  = each.value.hosts
  validation_method      = "http"
  validity_days          = 90
  certificate_authority  = "lets_encrypt"
  cloudflare_branding    = false
  wait_for_active_status = true
}

moved {
  from = cloudflare_certificate_pack.cert_apple_mdm
  to   = cloudflare_certificate_pack.custom_cert["apple-mdm"]
}