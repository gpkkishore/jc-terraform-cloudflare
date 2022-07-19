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
  source                    = "./modules/dns"
  zone_id                   = cloudflare_zone.cloudflare_zone_resource.id
  awsstg_dns_records        = local.awsstg_dns_records
  enable_awsstg             = var.enable_awsstg
  zone_name                 = var.zone_name
  enable_nonprod            = var.enable_nonprod
  ldap_aws_ns               = var.test_subdomain_delegation ? var.ldap_aws_ns_test : var.ldap_aws_ns
  ldap_mfa_aws_ns           = var.ldap_aws_mfa_ns
  prd_dns_records           = local.prd_dns_records
  radius_aws_ns             = var.test_subdomain_delegation ? var.radius_aws_ns_test : var.radius_aws_ns
  awsstg_aws_ns             = var.awsstg_aws_ns

}

module "security" {
  source  = "./modules/security"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

