resource "cloudflare_ruleset" "vaultone_owasp_core" {
  # This is the entrypoint ruleset for your zone
  zone_id = cloudflare_zone.additional_zone["vault.jumpcloud.com"].id
  name    = "vaultone_owasp_core"
  kind    = "zone"
  phase   = "http_request_firewall_managed"

  # This rule executes the managed OWASP Core Ruleset
  rules {
    action      = "execute"
    expression  = "true"
    description = "OWASP Core Ruleset"

    action_parameters {
      # The managed ruleset to be executed is specified by its ID.
      ruleset = "4814384a9e5d4991b9815dcfc25d2f1f"

      # This block is used to override the default settings of the managed ruleset.
      overrides {
        action = "log"
        rules {
          sensitivity_level = "medium"
          score_threshold   = 40
        }
      }
    }
  }
}
