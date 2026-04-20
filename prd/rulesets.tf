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
  name    = "CF managed rulesets overrides"
  kind    = "zone"
  phase   = "http_request_firewall_managed"

  rules {
    description = "Cloudflare Managed Ruleset"
    action      = "execute"
    expression  = "true"

    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
    }
  }

  rules {
    description = "Cloudflare OWASP Core Ruleset"
    action      = "execute"
    expression  = "true"

    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"

      overrides {
        # By default, all PL1 to PL4 rules are enabled.
        # Set the paranoia level to PL1 by disabling rules with
        # tags "paranoia-level-2", "paranoia-level-3" and "paranoia-level-4".
        categories {
          category = "paranoia-level-2"
          enabled  = false
        }
        categories {
          category = "paranoia-level-3"
          enabled  = false
        }
        categories {
          category = "paranoia-level-4"
          enabled  = false
        }
        rules {
          # This is the ID that controls the ruleset action.
          id     = "6179ae15870a4bb7b2d480d4843b323c"
          action = "managed_challenge"
        }
      }
    }
  }
}

###########################################
# vault.eu.jumpcloud.com
###########################################

resource "cloudflare_ruleset" "vault_eu_managed_waf" {
  zone_id = cloudflare_zone.additional_zone["vault.eu.jumpcloud.com"].id
  name    = "CF managed rulesets overrides"
  kind    = "zone"
  phase   = "http_request_firewall_managed"

  rules {
    description = "Cloudflare Managed Ruleset"
    action      = "execute"
    expression  = "true"

    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
    }
  }

  rules {
    description = "Cloudflare OWASP Core Ruleset"
    action      = "execute"
    expression  = "true"

    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"

      overrides {
        # By default, all PL1 to PL4 rules are enabled.
        # Set the paranoia level to PL1 by disabling rules with
        # tags "paranoia-level-2", "paranoia-level-3" and "paranoia-level-4".
        categories {
          category = "paranoia-level-2"
          enabled  = false
        }
        categories {
          category = "paranoia-level-3"
          enabled  = false
        }
        categories {
          category = "paranoia-level-4"
          enabled  = false
        }
        rules {
          # This is the ID that controls the ruleset action.
          id     = "6179ae15870a4bb7b2d480d4843b323c"
          action = "managed_challenge"
        }
      }
    }
  }
}

###########################################
# vault.in.jumpcloud.com
###########################################

resource "cloudflare_ruleset" "vault_in_managed_waf" {
  zone_id = cloudflare_zone.additional_zone["vault.in.jumpcloud.com"].id
  name    = "CF managed rulesets overrides"
  kind    = "zone"
  phase   = "http_request_firewall_managed"

  rules {
    description = "Cloudflare Managed Ruleset"
    action      = "execute"
    expression  = "true"

    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
    }
  }

  rules {
    description = "Cloudflare OWASP Core Ruleset"
    action      = "execute"
    expression  = "true"

    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"

      overrides {
        # By default, all PL1 to PL4 rules are enabled.
        # Set the paranoia level to PL1 by disabling rules with
        # tags "paranoia-level-2", "paranoia-level-3" and "paranoia-level-4".
        categories {
          category = "paranoia-level-2"
          enabled  = false
        }
        categories {
          category = "paranoia-level-3"
          enabled  = false
        }
        categories {
          category = "paranoia-level-4"
          enabled  = false
        }
        rules {
          # This is the ID that controls the ruleset action.
          id     = "6179ae15870a4bb7b2d480d4843b323c"
          action = "managed_challenge"
        }
      }
    }
  }
}

## Disable Email Obfuscation for Support Resources
resource "cloudflare_ruleset" "disable_email_obfuscation" {
  zone_id     = cloudflare_zone.cloudflare_zone_resource.id
  name        = "Disable Email Obfuscation"
  description = "Disable Email Obfuscation"
  kind        = "zone"
  phase       = "http_config_settings"

  rules {
    ref         = "disable_email_obfuscation_support"
    description = "Disable email obfuscation for Support requests"
    expression  = "(http.request.uri.path matches \"^/support\")"
    action      = "set_config"
    action_parameters {
      email_obfuscation = false
    }
  }

  rules {
    ref         = "disable_email_obfuscation_vdp"
    description = "Disable email obfuscation for Vulnerability Disclosure requests"
    expression  = "(http.request.uri.path matches \"^/vulnerability-disclosure-policy\")"
    action      = "set_config"
    action_parameters {
      email_obfuscation = false
    }
  }
}
