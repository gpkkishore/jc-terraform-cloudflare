resource "cloudflare_filter" "default" {
    zone_id = var.zone_id
    expression = "(ip.geoip.country eq \"RU\") or (ip.geoip.country eq \"BY\")"
}

resource "cloudflare_firewall_rule" "default" {
    zone_id = var.zone_id
    action = "block"
    filter_id = cloudflare_filter.default.id
    description = "Block Russia and Belarus"
}