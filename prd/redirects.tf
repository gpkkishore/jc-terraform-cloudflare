locals {
  ocsp_https_redirect_exemptions_by_zone_name = {
    "jumpcloud.com" = local.ocsp_hostnames
  }

  prd_http_dynamic_redirect_rule_specs_by_zone = {
    for z in data.cloudflare_zones.production_zones.zones : z.name => concat(
      z.name == "jumpcloud.com" ? [
        {
          description           = "WordPress Core Redirects"
          expression            = "(http.request.uri.path contains \"/wp-admin/setup-config.php\") or (http.request.uri.path contains \"/wp-admin/install.php\")"
          preserve_query_string = false
          target_url_expression = "concat(\"\", \"https://jumpcloud.com\")"
        },
        {
          description           = "Redirects iOS enrollment"
          expression            = "(http.request.full_uri wildcard r\"https://jumpcloud.com/.well-known/com.apple.remotemanagement*\")"
          preserve_query_string = false
          target_url_expression = "concat(\"\", \"https://apple.mdm.jumpcloud.com/account-driven-service-discovery?organization_id\")"
        },
      ] : [],
      [
        {
          description = "301 redirect HTTP to HTTPS, excluding exempt hostnames (if any) for this zone"
          expression = (
            length(lookup(local.ocsp_https_redirect_exemptions_by_zone_name, z.name, [])) == 0 ?
            "(not ssl)" :
            format("(not ssl) and not (http.host in {%s})", join(" ", [
              for h in lookup(local.ocsp_https_redirect_exemptions_by_zone_name, z.name, []) : format("\"%s\"", h)
            ]))
          )
          preserve_query_string = true
          target_url_expression = "concat(\"https://\", http.host, http.request.uri.path)"
        },
      ],
    )
  }
}

resource "cloudflare_ruleset" "http_to_https_redirect" {
  for_each = { for zone in data.cloudflare_zones.production_zones.zones : zone.id => zone }

  zone_id     = each.key
  name        = "Redirect HTTP to HTTPS"
  description = "Always Use HTTPS off; plaintext→HTTPS via this ruleset, with per-zone exempt hostnames where configured (replaces AUH)."
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  dynamic "rules" {
    for_each = local.prd_http_dynamic_redirect_rule_specs_by_zone[each.value.name]
    content {
      description = rules.value.description
      enabled     = true
      expression  = rules.value.expression
      action      = "redirect"

      action_parameters {
        from_value {
          status_code           = 301
          preserve_query_string = rules.value.preserve_query_string

          target_url {
            expression = rules.value.target_url_expression
          }
        }
      }
    }
  }
}
