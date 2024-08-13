moved {
  from = cloudflare_zone_dnssec.prd02_jumpcloud_com
  to   = cloudflare_zone_dnssec.zones_with_dnssec["prd02.jumpcloud.com"]
}

moved {
  from = cloudflare_zone_dnssec.zones_with_dnssec
  to   = cloudflare_zone_dnssec.child_zones_with_dnssec
}
