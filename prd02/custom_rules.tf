locals {
  # OCSP service hostnames
  ocsp_hostnames = [
    "ocsp.prd02.jumpcloud.com",
  ]

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
   * Additonal Rate Limit Rules for the prd02 environment
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
      expression  = "(http.request.uri.path eq \"/auth\" and http.host eq \"console.prd02.jumpcloud.com\" and http.request.method eq \"POST\" and not http.user_agent contains \"Datadog\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        period              = 120
        requests_per_period = 10
        mitigation_timeout  = 300
      }
    },
    {
      action       = "block"
      description  = "WAF Attack"
      expression   = "(cf.waf.score lt 5)"

      ratelimit = {
        characteristics     = ["cf.colo.id","ip.src",]
        counting_expression = "(http.response.code eq 521)"
        mitigation_timeout  = 600
        period              = 10
        requests_per_period = 100
        requests_to_origin  = false
      },
    },
    # OCSP Rate Limiting Rules
    # Phase 1: Block clearly malformed requests before backend processing
    {
      action      = "block"
      description = "OCSP - Block requests missing Content-Type header"
      expression  = "(http.host in {${join(" ", [for host in local.ocsp_hostnames : format("\"%s\"", host)])}}) and not any(lower(http.request.headers.names[*])[*] eq \"content-type\")"

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
      description = "OCSP - Successful response cap (5-minute, 3000 limit)"
      expression  = "(http.host in {${join(" ", [for host in local.ocsp_hostnames : format("\"%s\"", host)])}})"

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
      description = "OCSP - Unauthorized response cap (5-minute, 300 limit)"
      expression  = "(http.host in {${join(" ", [for host in local.ocsp_hostnames : format("\"%s\"", host)])}})"

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
      description = "OCSP - Overall rate limit safety net (50 rps)"
      expression  = "(http.host in {${join(" ", [for host in local.ocsp_hostnames : format("\"%s\"", host)])}})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 10
        requests_per_period = 500
        mitigation_timeout  = 60
      }
    }
  ]

  /**
   * Additonal WAF Rules for the prd02 environment
   */
  add_waf_rules = [
    // TE-2367 Directory Insights representative-path synthetic only (paging/corroboration;
    // not P0 actuation or automation-eligible). Production console/login P0 probes are unchanged.
    {
      action      = "skip"
      description = "Allow Datadog managed-location TE-2367 Directory Insights canary (paging-only; not P0/automation-eligible)"
      expression  = format("(http.user_agent eq \"Datadog/Synthetics\" and ip.src in {%s} and http.host eq \"api.eu.jumpcloud.com\" and http.request.uri.path eq \"/insights/directory/v1/__edge_probe__\")", join(" ", local.datadog_managed_synthetics_ips))
    },
    {
      action      = "block"
      description = "Allow ZScaler only"
      expression  = "(http.host in {\"jumpdesk.prd02.jumpcloud.com\"} and not ip.src in {54.187.222.118 54.218.209.46 35.165.242.218 54.86.134.208 54.86.96.53 54.86.131.111 52.70.132.28 52.43.62.126 54.245.68.23 35.161.74.70 52.73.14.42 3.219.213.81 44.216.132.195})"
    },
    {
      action      = "block"
      description = "20240513-jccom-outage"
      expression  = "(ip.geoip.asnum eq 45102 and http.host eq \"prd02.jumpcloud.com\" and http.request.uri.path eq \"/careers\")"
    },
    {
      action       = "managed_challenge"
      description  = "Managed Captcha Abuse IP's 20241224-haproxy"
      expression   = "(ip.src in {52.13.24.213 34.208.1.174 44.245.128.2 44.244.196.227 3.211.203.108 44.237.194.38 54.69.0.153 44.235.57.22})"
    },
  ]
}
