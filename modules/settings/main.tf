# This module contains settings applicable to all zones

# Custom zone settings, defaults if not explicitly set
resource "cloudflare_zone_settings_override" "zones_settings_override" {
  zone_id = var.zone_id
  settings {
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    true_client_ip_header    = "on"
  }
}
