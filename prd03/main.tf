resource "cloudflare_zone" "cloudflare_zone_resource" {
  account_id = local.cloudflare_account
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

module "dns" {
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=3.0.0"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.prd03_dns_records
  ns_delegation = local.prd03_ns_delegation_records
}

module "security" {
  source = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.2.0"

  zone_id                    = cloudflare_zone.cloudflare_zone_resource.id
  additional_ratelimit_rules = local.add_ratelimit_rules
  additional_waf_rules       = local.add_waf_rules
}

module "settings" {
  source  = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=v2.0.2"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

############################################################
# Custom Certificate Pack Resources for edge Certificates
############################################################
resource "cloudflare_certificate_pack" "custom_cert_09042024" {
  for_each = { for cert in local.custom_certs : cert.name => cert }

  zone_id                = cloudflare_zone.cloudflare_zone_resource.id
  type                   = "advanced"
  hosts                  = each.value.hosts
  validation_method      = each.value.validation_method
  validity_days          = 90
  certificate_authority  = "google"
  cloudflare_branding    = false
  wait_for_active_status = true
}
