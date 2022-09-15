provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = "us-west-2"
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
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/dns?ref=v1.1.0"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.stg_dns_records
  ns_delegation = local.stg_ns_delegation_records
}

module "security" {
  source  = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/security?ref=v1.1.1"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

module "settings" {
  source = "../modules/settings"
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
