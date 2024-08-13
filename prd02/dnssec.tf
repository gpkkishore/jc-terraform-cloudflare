############################################################
# Create DS records DNSSEC for PRD02 Zone and enable DNSSEC
############################################################
resource "cloudflare_zone_dnssec" "prd02_jumpcloud_com" {
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}
