locals {
  # PKI service hostnames (OCSP + SCEP) (shared: redirect exemption + Cloudflare rate limiting)
  pki_hostnames = [
    "ocsp.in.jumpcloud.com",
    "scep.in.jumpcloud.com",
  ]

  # jcs_* service account requests on *.in.jumpcloud.com hosts (NA-4759).
  # Per-API-key CF counting requires Advanced Rate Limiting (not entitled) — HAProxy (NA-4759).
  jcs_api_key_ratelimit_expression = "((ends_with(http.host, \".in.jumpcloud.com\") or http.host eq \"in.jumpcloud.com\") and len(http.request.headers[\"x-api-key\"]) > 0 and starts_with(lower(http.request.headers[\"x-api-key\"][0]), \"jcs_\"))"

  # Datadog managed-location egress for approved synthetic probe locations.
  # Source: https://ip-ranges.datadoghq.com/synthetics.json
  # Locations: aws:us-east-1, aws:eu-west-1, aws:ap-southeast-2
  datadog_managed_synthetics_ips = [
    # aws:us-east-1
    "3.41.176.48/29",
    "3.92.150.182/32",
    "52.55.56.26/32",
    "107.21.25.247/32",
    # aws:eu-west-1
    "3.40.134.72/29",
    "18.200.120.237/32",
    "63.34.100.178/32",
    "63.35.33.198/32",
    # aws:ap-southeast-2
    "13.54.169.48/32",
    "13.236.246.161/32",
    "13.238.14.57/32",
    "18.98.196.216/29",
  ]

  /**
   * Additonal Rate Limit Rules for the prd03 environment
   */
  add_ratelimit_rules = [
    {
      action      = "block"
      description = "Per IP rate limit on routes containing /api/systems"
      expression  = "(http.request.uri.path contains \"/api/systems\" and http.request.method eq \"PUT\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        period              = 60
        requests_per_period = 1000
        mitigation_timeout  = 60
      }
    },
    {
      action      = "block"
      description = "Admin Auth Request Rate Limit - ir-124"
      expression  = "(http.request.uri.path eq \"/auth\" and http.host eq \"console.in.jumpcloud.com\" and http.request.method eq \"POST\" and not http.user_agent contains \"Datadog\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        period              = 120
        requests_per_period = 10
        mitigation_timeout  = 300
      }
    },
    # Service account API keys (jcs_*) — per-IP edge rate limit (NA-4759).
    # Org/provider fair-share is enforced in-app (service-accounts).
    # Per-API-key limits: HAProxy stick tables (NA-4759); CF header characteristics
    # require Advanced Rate Limiting plan (not entitled).
    {
      action      = "block"
      description = "Service account API key (jcs_*) per-IP rate limit - *.in.jumpcloud.com"
      expression  = local.jcs_api_key_ratelimit_expression

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 2000
        mitigation_timeout  = 60
      }
    },
    {
      action      = "block"
      description = "Per IP rate limit on POST /changepassword - 3000/60s"
      expression  = "(http.request.method eq \"POST\" and (http.request.uri.path eq \"/changepassword\" or starts_with(http.request.uri.path, \"/changepassword/\")))"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 3000
        mitigation_timeout  = 90
      }
    },
    {
      action      = "block"
      description = "Per IP burst rate limit on POST /changepassword - 600/10s"
      expression  = "(http.request.method eq \"POST\" and (http.request.uri.path eq \"/changepassword\" or starts_with(http.request.uri.path, \"/changepassword/\")))"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 10
        requests_per_period = 600
        mitigation_timeout  = 20
      }
    },
    {
      action      = "block"
      description = "WAF Attack"
      expression  = "(cf.waf.score lt 5)"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src", ]
        counting_expression = "(http.response.code eq 521)"
        mitigation_timeout  = 600
        period              = 10
        requests_per_period = 100
        requests_to_origin  = false
      },
    },
    # PKI Rate Limiting Rules
    # Phase 1: Block clearly malformed requests before backend processing
    {
      action      = "block"
      description = "OCSP - Block requests missing Content-Type header"
      expression  = "(http.host in {\"ocsp.in.jumpcloud.com\"}) and not any(lower(http.request.headers.names[*])[*] eq \"content-type\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 2
        mitigation_timeout  = 300
      }
    },
    # Phase 2: Cap successful responses at 3,000 per 5 minutes
    {
      action      = "block"
      description = "PKI - Successful response cap (5-minute, 3000 limit)"
      expression  = "(http.host in {${join(" ", [for host in local.pki_hostnames : format("\"%s\"", host)])}})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = "(http.response.code eq 200)"
        period              = 300
        requests_per_period = 3000
        mitigation_timeout  = 300
      }
    },
    # Phase 3: Cap unauthorized responses at 300 per 5 minutes
    {
      action      = "block"
      description = "PKI - Unauthorized response cap (5-minute, 300 limit)"
      expression  = "(http.host in {${join(" ", [for host in local.pki_hostnames : format("\"%s\"", host)])}})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = "(http.response.code eq 401)"
        period              = 300
        requests_per_period = 300
        mitigation_timeout  = 300
      }
    },
    # Phase 4: Safety net - overall per-IP rate limit (50 rps)
    {
      action      = "block"
      description = "PKI - Overall rate limit safety net (50 rps)"
      expression  = "(http.host in {${join(" ", [for host in local.pki_hostnames : format("\"%s\"", host)])}})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 10
        requests_per_period = 500
        mitigation_timeout  = 60
      }
    },
    {
      action      = "block"
      description = "ai.jumpcloud.com - GET /.well-known/* rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"GET\" and starts_with(http.request.uri.path, \"/.well-known/\"))"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 60
        mitigation_timeout  = 60
      }
    },
    {
      action      = "block"
      description = "ai.jumpcloud.com - POST /mcp/oauth/register and /oauth/register rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"POST\" and http.request.uri.path in {\"/mcp/oauth/register\" \"/oauth/register\"})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 1800
        requests_per_period = 30
        mitigation_timeout  = 0 # throttling
      }
    },
    {
      action      = "block"
      description = "ai.jumpcloud.com - GET /mcp/oauth/authorize and /oauth/authorize rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"GET\" and http.request.uri.path in {\"/mcp/oauth/authorize\" \"/oauth/authorize\"})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 30
        mitigation_timeout  = 60
      }
    },
    # Token endpoint serves machine-to-machine client_credentials traffic (e.g. AWS
    # AgentCore) arriving from a few shared cloud egress IPs, so per-IP limits must
    # be high. A 60s cooldown still contains a single misbehaving client (CAT-2345).
    {
      action      = "block"
      description = "ai.jumpcloud.com - POST /mcp/oauth/token and /oauth/token rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"POST\" and http.request.uri.path in {\"/mcp/oauth/token\" \"/oauth/token\"})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 3000
        mitigation_timeout  = 60
      }
    },
    {
      action      = "block"
      description = "ai.jumpcloud.com - POST /mcp rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"POST\" and http.request.uri.path eq \"/mcp\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 60
        mitigation_timeout  = 60
      }
    },
    {
      action      = "block"
      description = "ai.jumpcloud.com - GET /mcp SSE rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"GET\" and http.request.uri.path eq \"/mcp\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 200
        mitigation_timeout  = 60
      }
    },
    {
      action      = "block"
      description = "ai.jumpcloud.com - DELETE /mcp rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"DELETE\" and http.request.uri.path eq \"/mcp\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 60
        mitigation_timeout  = 60
      }
    },
  ]

  /**
   * Additonal WAF Rules for the prd03 environment
   * TODO: Review and update ZScaler IPs and abuse IPs for prd03 (ap-south-1).
   * The IPs below are carried over from prd02 and may need adjustment.
   */
  add_waf_rules = [
    // TE-2367 Directory Insights representative-path synthetic only (paging/corroboration;
    // not P0 actuation or automation-eligible). Production console/login P0 probes are unchanged.
    {
      action      = "skip"
      description = "Allow Datadog managed-location TE-2367 Directory Insights canary (paging-only; not P0/automation-eligible)"
      expression  = format("(http.user_agent eq \"Datadog/Synthetics\" and ip.src in {%s} and http.host eq \"api.in.jumpcloud.com\" and http.request.uri.path eq \"/insights/directory/v1/__edge_probe__\")", join(" ", local.datadog_managed_synthetics_ips))
    },
    {
      action      = "block"
      description = "Blocking Abuse IP's"
      expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213 80.94.93.220 136.0.213.5 172.239.50.62 134.199.209.82 2600:3c06:0:0:2000:9fff:feb2:5f63} and http.host contains \"in.jumpcloud.com\")"
    },
    {
      action      = "block"
      description = "Allow ZScaler only - IN"
      expression  = "(http.host in {\"jumpdesk.in.jumpcloud.com\" \"polaris-console.in.jumpcloud.com\" \"trino.in.jumpcloud.com\" } and not ip.src in {54.187.222.118 54.218.209.46 35.165.242.218 54.86.134.208 54.86.96.53 54.86.131.111 52.70.132.28 52.43.62.126 54.245.68.23 35.161.74.70 52.73.14.42 3.219.213.81 44.216.132.195 13.235.236.32})"
    },
  ]
}
