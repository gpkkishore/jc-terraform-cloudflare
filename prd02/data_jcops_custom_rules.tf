locals {
  euc1_zscaler_natgws   = join(" ", data.aws_ec2_managed_prefix_list.euc1_zscaler_natgws.entries[*].cidr)
  prd02_euc1_c00_natgws = join(" ", data.aws_ec2_managed_prefix_list.prd02_euc1_c00_natgws.entries[*].cidr)

  us_east_1_saleseng_ngw = "52.70.132.28/32"

  # PKI service hostnames (OCSP + SCEP) (shared: redirect exemption + Cloudflare rate limiting)
  pki_hostnames = [
    "ocsp.eu.jumpcloud.com",
    "scep.eu.jumpcloud.com",
  ]

  vaultone_prd02_euc1_natgws    = "18.199.25.0/32 3.125.68.115/32 3.76.171.84/32"
  vaultone_homolog_mulesoft_ips = "13.216.65.20/32 34.204.246.90/32 54.227.37.138/32 3.216.39.193/32 35.168.81.102/32 54.160.118.35/32 54.165.222.204/32 3.225.136.12/32"

  vaultone_vault_eu_allowed_ips = join(" ", [
    local.us_east_1_saleseng_ngw,
    local.prd02_euc1_c00_natgws,
    local.euc1_zscaler_natgws,
    local.vaultone_prd02_euc1_natgws,
    local.vaultone_homolog_mulesoft_ips,
  ])

  eu_jcops_add_ratelimit_rules = [
    {
      action      = "block"
      description = "Rate Limit api/commandresults by IP - 11 Jan 2024"
      expression  = "(http.request.uri.path contains \"api/commandresults\" and ip.src in {52.77.97.81})"

      ratelimit = {
        counting_expression = null
        characteristics     = ["cf.colo.id", "ip.src"]
        period              = 60
        requests_per_period = 20
        mitigation_timeout  = 0
      }
    },
    {
      action      = "block"
      description = "Rate Limit api/commandresults by IP - 25 May 2023"
      expression  = "(http.request.uri.path contains \"api/commandresults\" and ip.src in {34.226.132.221 52.54.43.157})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        period              = 10
        requests_per_period = 100
        mitigation_timeout  = 10
      }
    },
    {
      action      = "block"
      description = "Rate Limit api/commandresults by IP - 27 Mar 2024"
      expression  = "(http.request.uri.path contains \"api/commandresults\" and ip.src in {186.193.232.31 191.243.208.231})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        period              = 10
        requests_per_period = 50
        mitigation_timeout  = 10
      }
    },
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
      description = "Admin Auth Request Rate Limit - ir-124 - EU"
      expression  = "(http.request.uri.path eq \"/auth\" and http.host eq \"console.eu.jumpcloud.com\" and http.request.method eq \"POST\" and not http.user_agent contains \"Datadog\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        period              = 120
        requests_per_period = 10
        mitigation_timeout  = 300
      }
    },
    {
      action      = "log"
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
      action      = "log"
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
    {
      action      = "block"
      description = "ai.eu.jumpcloud.com - GET /.well-known/* rate limit"
      expression  = "(http.host eq \"ai.eu.jumpcloud.com\" and http.request.method eq \"GET\" and starts_with(http.request.uri.path, \"/.well-known/\"))"

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
      description = "ai.eu.jumpcloud.com - POST /mcp/oauth/register rate limit"
      expression  = "(http.host eq \"ai.eu.jumpcloud.com\" and http.request.method eq \"POST\" and http.request.uri.path eq \"/mcp/oauth/register\")"

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
      description = "ai.eu.jumpcloud.com - GET /mcp/oauth/authorize rate limit"
      expression  = "(http.host eq \"ai.eu.jumpcloud.com\" and http.request.method eq \"GET\" and http.request.uri.path eq \"/mcp/oauth/authorize\")"

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
      description = "ai.eu.jumpcloud.com - POST /mcp/oauth/token rate limit"
      expression  = "(http.host eq \"ai.eu.jumpcloud.com\" and http.request.method eq \"POST\" and http.request.uri.path eq \"/mcp/oauth/token\")"

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
      description = "ai.eu.jumpcloud.com - POST /mcp rate limit"
      expression  = "(http.host eq \"ai.eu.jumpcloud.com\" and http.request.method eq \"POST\" and http.request.uri.path eq \"/mcp\")"

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
      description = "ai.eu.jumpcloud.com - GET /mcp SSE rate limit"
      expression  = "(http.host eq \"ai.eu.jumpcloud.com\" and http.request.method eq \"GET\" and http.request.uri.path eq \"/mcp\")"

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
      description = "ai.eu.jumpcloud.com - DELETE /mcp rate limit"
      expression  = "(http.host eq \"ai.eu.jumpcloud.com\" and http.request.method eq \"DELETE\" and http.request.uri.path eq \"/mcp\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 60
        mitigation_timeout  = 60
      }
    },
    # OCSP Rate Limiting Rules
    # PKI Rate Limiting Rules
    # Phase 1: Block clearly malformed requests before backend processing
    {
      action      = "block"
      description = "OCSP - Block requests missing Content-Type header"
      expression  = "(http.host eq \"ocsp.eu.jumpcloud.com\") and not any(lower(http.request.headers.names[*])[*] eq \"content-type\")"

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
  ]

  eu_jcops_waf_rules  = [
    { // allow pentest IP, to be removed after pentest is complete
      action      = "skip"
      description = "Allow Pentest IPs"
      expression  = "(ip.src in {216.71.114.64 50.34.38.206} and http.host contains \"jumpcloud.com\")"
    },
    {
      action      = "block"
      description = "Allow ZScaler only - EU"
      expression  = "(http.host in {\"jumpdesk.eu.jumpcloud.com\" \"polaris-console.eu.jumpcloud.com\" \"trino.eu.jumpcloud.com\"} and not ip.src in {54.187.222.118 54.218.209.46 35.165.242.218 54.86.134.208 54.86.96.53 54.86.131.111 52.70.132.28 52.43.62.126 54.245.68.23 35.161.74.70 52.73.14.42 3.219.213.81 44.216.132.195 3.79.78.24 52.57.217.97})"
    },
    {
      action      = "managed_challenge"
      description = "Managed Captcha Abuse IP's 20241224-haproxy"
      expression  = "(ip.src in {52.13.24.213 34.208.1.174 44.245.128.2 44.244.196.227 3.211.203.108 44.237.194.38 54.69.0.153 44.235.57.22})"
    },
    {
      action      = "block"
      description = "Blocking Abuse IP's"
      expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213 80.94.93.220 136.0.213.5 172.239.50.62 134.199.209.82 2600:3c06:0:0:2000:9fff:feb2:5f63 2402:a00:402:5a6b:6caf:cea1:9ccf:9f99} and http.host contains \"jumpcloud.com\")"
    },
  ]

  vault_eu_waf_rules = [
    {
      action      = "skip"
      description = "Allow vault.eu.jumpcloud assets (404 page, etc.)"
      expression  = "(http.host eq \"vault.eu.jumpcloud.com\" and starts_with(http.request.uri.path, \"/assets\"))"
    },
    {
      action      = "block"
      description = "Blocking Abuse IP's"
      expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213 172.239.50.62 134.199.209.82 2600:3c06:0:0:2000:9fff:feb2:5f63} and http.host contains \"jumpcloud.com\")"
    },
    {
      action      = "block"
      description = "Allow ZScaler only for certain endpoints"
      expression  = format("(http.host eq \"vault.eu.jumpcloud.com\" or http.host eq \"app.vault.eu.jumpcloud.com\" or http.host eq \"api.vault.eu.jumpcloud.com\") and not ip.src in {%s}", local.vaultone_vault_eu_allowed_ips)
    },
  ]

  eu_jcops_add_waf_rules = concat(local.eu_jcops_waf_rules, local.vault_eu_waf_rules)
}

data "aws_ec2_managed_prefix_list" "euc1_zscaler_natgws" {
  name = "euc1-zscaler-natgws"
}

data "aws_ec2_managed_prefix_list" "prd02_euc1_c00_natgws" {
  name = "prd02-euc1-c00-natgws"
}

