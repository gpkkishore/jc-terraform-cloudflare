locals {
  stg01_http_to_https_redirect_expression = length(local.ocsp_hostnames) == 0 ? "(not ssl)" : format("(not ssl) and not (http.host in {%s})", join(" ", [for h in local.ocsp_hostnames : format("\"%s\"", h)]))
}

resource "cloudflare_ruleset" "http_to_https_redirect" {
  zone_id     = cloudflare_zone.cloudflare_zone_resource.id
  name        = "Redirect HTTP to HTTPS (excluding OCSP)"
  description = "Replaces zone-wide Always Use HTTPS so OCSP can serve plaintext HTTP on dedicated hosts."
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules {
    description = "301 redirect HTTP to HTTPS except OCSP hosts"
    enabled     = true
    expression  = local.stg01_http_to_https_redirect_expression
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
