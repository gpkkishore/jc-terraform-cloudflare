# This file contains zone-specific managed WAF rulesets that override the 
# default managed rulesets defined in the terraform-cloudflare-security module.
# 
# To use these overrides:
# 1. Set skip_managed_rulesets = true in the security module for the specific zone
# 2. Define the custom managed ruleset configuration in this file
# 
# This prevents conflicts between the default security module rulesets and 
# zone-specific customizations.

###########################################
# vault.jumpcloud.com
###########################################

resource "cloudflare_ruleset" "vault_managed_waf" {
  zone_id = cloudflare_zone.additional_zone["vault.jumpcloud.com"].id
  name    = "Managed WAF entry point ruleset"
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

  rules {
    action      = "execute"
    expression  = "true"
    description = "Cloudflare OWASP Core Ruleset"

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
