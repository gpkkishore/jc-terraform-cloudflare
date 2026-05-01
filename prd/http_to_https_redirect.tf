locals {
  ocsp_https_redirect_exemptions_by_zone_name = {
    "jumpcloud.com" = local.ocsp_hostnames
  }

  prd_http_to_https_redirect_expression_by_zone_name = {
    for z in data.cloudflare_zones.production_zones.zones : z.name => (
      length(lookup(local.ocsp_https_redirect_exemptions_by_zone_name, z.name, [])) == 0
      ? "(not ssl)"
      : format("(not ssl) and not (http.host in {%s})", join(" ", [for h in lookup(local.ocsp_https_redirect_exemptions_by_zone_name, z.name, []) : format("\"%s\"", h)]))
    )
  }
}

resource "cloudflare_ruleset" "http_to_https_redirect" {
  for_each = { for z in data.cloudflare_zones.production_zones.zones : z.id => z }

  zone_id     = each.key
  name        = "Redirect HTTP to HTTPS (excluding OCSP)"
  description = "Replaces zone-wide Always Use HTTPS so OCSP can serve plaintext HTTP on dedicated hosts."
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules {
    description = "301 redirect HTTP to HTTPS except OCSP hosts (if any) in this zone"
    enabled     = true
    expression  = local.prd_http_to_https_redirect_expression_by_zone_name[each.value.name]
    action      = "redirect"

    action_parameters {
      from_value {
        status_code           = 301
        preserve_query_string = true
        target_url {
          expression = "concat(\"https://\", http.host, http.request.uri.path)"
        }
      }
    }
  }
}
