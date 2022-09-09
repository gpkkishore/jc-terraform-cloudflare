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

# Forward Russia and Belarus http traffic to security-dmz-alb-prd-eu-north-1-523783178.eu-north-1.elb.amazonaws.com (451 Unavailable For Legal Reasons)
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
          value = "/security-dmz-alb-prd-eu-north-1-523783178.eu-north-1.elb.amazonaws.com"
        }
      }
    }

    expression  = "(ip.geoip.country eq \"RU\") or (ip.geoip.country eq \"BY\")"
    description = "Forward Russia and Belarus"
    enabled     = true
  }
}

######################################
# Cloudflare Managed WAF Settings
######################################
resource "cloudflare_ruleset" "zone_level_managed_waf" {
  zone_id     = var.zone_id
  name        = "Managed WAF entry point ruleset"
  kind        = "zone"
  phase       = "http_request_firewall_managed"

  rules {
    action = "execute"
    action_parameters {
      id = "c2e184081120413c86c3ab7e14069605"
      version = "latest"
    }
    expression = "true"
    description = "Cloudflare Exposed Credentials Check Ruleset"
    enabled = true
  }

  rules {
    action = "execute"
    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"
      version = "latest"
    }
    expression = "true"
    description = "Cloudflare's implementation of the Open Web Application Security Project (OWASP) ModSecurity Core Rule Set."
    enabled = true
  }

  rules {
    action = "execute"
    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
      version = "latest"
    }
    expression = "true"
    description = "Created by the Cloudflare security team, this ruleset is designed to provide fast and effective protection for all your applications."
    enabled = true
  }
}