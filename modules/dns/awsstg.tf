// Simple dns records from awsstg.jumpcloud.com

# Needs to be transferred from jumpcloud.com to awsstg.jumpcloud.com

resource "cloudflare_record" "terraform_managed_resource_608bc6ffdcb06e692954b600db1f4d82" {
  count   = var.enable_awsstg == true ? 1 : 0
  name    = "awsstg.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "google-site-verification=fUOm_FpYJ2K5rcOwrAUxvJRIjl5klKUl11FdvUx-yRw"
  zone_id = var.zone_id
}
/*
resource "cloudflare_record" "ldap2_awsstg" {
  name = "ldap.awsstg"
  proxied = false
  ttl = 1
  type = "A"
  value = "10.20.33.198"
  zone_id = var.zone_id
}
*/
resource "cloudflare_record" "radius2_awsstg" {
  count   = var.enable_awsstg == true ? 1 : 0
  name    = "radius.awsstg"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "13.57.87.164"
  zone_id = var.zone_id
}