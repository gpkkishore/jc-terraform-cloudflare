locals {
  # PKI service hostnames (OCSP + SCEP) (shared: redirect exemption + Cloudflare rate limiting)
  pki_hostnames = [
    "ocsp.in.jumpcloud.com",
    "scep.in.jumpcloud.com",
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
      description = "ai.jumpcloud.com - POST /mcp/oauth/register rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"POST\" and http.request.uri.path eq \"/mcp/oauth/register\")"

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
      description = "ai.jumpcloud.com - GET /mcp/oauth/authorize rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"GET\" and http.request.uri.path eq \"/mcp/oauth/authorize\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 30
        mitigation_timeout  = 60
      }
    },
    {
      action      = "block"
      description = "ai.jumpcloud.com - POST /mcp/oauth/token rate limit"
      expression  = "(http.host in {\"ai.in.jumpcloud.com\"} and http.request.method eq \"POST\" and http.request.uri.path eq \"/mcp/oauth/token\")"

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
