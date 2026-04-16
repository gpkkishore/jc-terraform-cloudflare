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
    {
      action      = "managed_challenge"
      description = "Rate Limit Login Attempts"
      expression  = "(http.host eq \"console.in.jumpcloud.com\" and http.request.uri.path eq \"/login\")"

      ratelimit = {
        counting_expression = null
        characteristics     = ["ip.src"]
        period              = 60
        requests_per_period = 10
        mitigation_timeout  = 600
      }
    },
    {
      action      = "managed_challenge"
      description = "Challenge Excessive 404s (Scanners)"
      expression  = "(not cf.bot_management.verified_bot) and (http.host ne \"mcp.in.jumpcloud.com\") and (not http.host contains \"mdm\") and (not http.user_agent contains \"hubd\")"

      ratelimit = {
        characteristics     = ["ip.src"]
        counting_expression = "(http.response.code eq 404)"
        period              = 60
        requests_per_period = 20
        mitigation_timeout  = 600
      }
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
      description = "Blocking Abuse IP's"
      expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213 80.94.93.220 136.0.213.5 172.239.50.62 134.199.209.82 2600:3c06:0:0:2000:9fff:feb2:5f63} and http.host contains \"in.jumpcloud.com\")"
    },
    {
      action      = "block"
      description = "Allow ZScaler only - IN"
      expression  = "(http.host in {\"jumpdesk.in.jumpcloud.com\"} and not ip.src in {54.187.222.118 54.218.209.46 35.165.242.218 54.86.134.208 54.86.96.53 54.86.131.111 52.70.132.28 52.43.62.126 54.245.68.23 35.161.74.70 52.73.14.42 3.219.213.81 44.216.132.195 13.235.236.32})"
    },
    {
      action      = "managed_challenge"
      description = "Blocking Pentest Paths"
      expression  = "(http.host in {\"saas.in.jumpcloud.com\"} and http.request.uri.path in {\"/wp-login.php\" \"/wp-admin/index.php\"})"
    },
  ]
}
