moved {
  from = cloudflare_zone_dnssec.jumpcloud_com
  to   = cloudflare_zone_dnssec.zones_with_dnssec["jumpcloud.com"]
}
