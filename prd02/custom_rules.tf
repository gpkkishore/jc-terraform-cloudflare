locals {
  /**
   * Additonal Rate Limit Rules for the prd02 environment
   */
  add_ratelimit_rules = [
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
    }
  ]

  /**
   * Additonal WAF Rules for the prd02 environment
   */
  add_waf_rules = [
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
