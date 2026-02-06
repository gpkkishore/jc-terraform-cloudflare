locals {
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
      expression  = "(http.request.uri.path eq \"/auth\" and http.host eq \"console.prd03.jumpcloud.com\" and http.request.method eq \"POST\" and not http.user_agent contains \"Datadog\")"

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
        characteristics     = ["cf.colo.id", "ip.src",]
        counting_expression = "(http.response.code eq 521)"
        mitigation_timeout  = 600
        period              = 10
        requests_per_period = 100
        requests_to_origin  = false
      },
    }
  ]

  /**
   * Additonal WAF Rules for the prd03 environment
   * TODO: Review and update ZScaler IPs and abuse IPs for prd03 (ap-south-1).
   * The IPs below are carried over from prd02 and may need adjustment.
   */
  add_waf_rules = [
    {
      action      = "block"
      description = "Allow ZScaler only"
      expression  = "(http.host in {\"jumpdesk.prd03.jumpcloud.com\"} and not ip.src in {54.187.222.118 54.218.209.46 35.165.242.218 54.86.134.208 54.86.96.53 54.86.131.111 52.70.132.28 52.43.62.126 54.245.68.23 35.161.74.70 52.73.14.42 3.219.213.81 44.216.132.195})"
    },
  ]
}
