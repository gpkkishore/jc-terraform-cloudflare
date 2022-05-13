# Filter Russia and Belarus
resource "cloudflare_filter" "russia_belarus" {
  zone_id     = var.zone_id
  description = "Filter Russia and Belarus"
  expression  = "(ip.geoip.country eq \"RU\") or (ip.geoip.country eq \"BY\")"
}

# Block Russia and Belarus
resource "cloudflare_firewall_rule" "block_russia_belarus" {
  zone_id     = var.zone_id
  filter_id   = cloudflare_filter.russia_belarus.id
  description = "Block Russia and Belarus"
  action      = "block"
}

# Forward Russia and Belarus http traffic to 3.122.247.12 (451 Unavailable For Legal Reasons)
resource "cloudflare_ruleset" "transform_uri_russia_belarus" {
  zone_id     = var.zone_id
  name        = "Forward Russia and Belarus"
  description = "Transform URI path for Russia and Belarus http traffic to a new static path"
  kind        = "zone"
  phase       = "http_request_transform"

  rules {
    action = "rewrite"
    action_parameters {
      uri {
        path {
          value = "/3.122.247.12"
        }
      }
    }

    expression  = "(ip.geoip.country eq \"RU\") or (ip.geoip.country eq \"BY\")"
    description = "Forward Russia and Belarus"
    enabled     = true
  }
}