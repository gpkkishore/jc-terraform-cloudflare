## Cloudflare Managed Ruleset

# vault.jumpcloud.com
resource "cloudflare_ruleset" "cloudflare_managed_ruleset" {
  zone_id = cloudflare_zone.additional_zone["vault.jumpcloud.com"].id
  name    = "Cloudflare Managed Ruleset"
  kind    = "zone"
  phase   = "http_request_firewall_managed"

  rules {
    action      = "execute"
    expression  = "true"
    description = "Cloudflare Managed Ruleset"

    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
    }
  }
}

resource "cloudflare_ruleset" "cloudflare_owasp_core_ruleset" {
  zone_id = cloudflare_zone.additional_zone["vault.jumpcloud.com"].id
  name    = "Cloudflare OWASP Core Ruleset"
  kind    = "zone"
  phase   = "http_request_firewall_managed"

  rules {
    action      = "execute"
    expression  = "true"
    description = "OWASP Core Ruleset"

    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"
      overrides {
        action = "managed_challenge"
        rules {
          sensitivity_level = "medium"
          score_threshold   = 40
        }
      }
    }
  }
}

resource "cloudflare_ruleset" "cloudflare_leaked_credentials_check" {
  zone_id = cloudflare_zone.additional_zone["vault.jumpcloud.com"].id
  name    = "Cloudflare Leaked Credentials Check"
  kind    = "zone"
  phase   = "http_request_firewall_managed"

  rules {
    action      = "execute"
    expression  = "true"
    description = "Cloudflare Leaked Credentials Check"

    action_parameters {
      id = "c2e184081120413c86c3ab7e14069605"
      overrides {
        action = "log"
      }
    }
  }
}
