resource "cloudflare_zone" "cloudflare_zone_resource" {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = var.cloudflare_account_id
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

module "dns" {
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=2.0.1"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.tst_dns_records
  ns_delegation = local.tst_ns_delegation_records
}

module "security" {
  source  = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.0.1"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

module "settings" {
  source  = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
  # Module default always_use_https = "on"; dev has no OCSP/plain-HTTP hosts at the edge.
}
