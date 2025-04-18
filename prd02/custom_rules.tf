locals {
  /**
   * Additonal Rate Limit Rules for the prd02 environment
   */
  add_ratelimit_rules = []

  /**
   * Additonal WAF Rules for the prd02 environment
   */
  add_waf_rules = [
    // Skip if IP is in NAT GW list
    {
      action      = "skip"
      description = "Allow NATGWs"
      expression  = "ip.src in {18.197.88.221 3.65.75.217 35.159.138.1 3.125.125.36 3.65.73.181 3.77.209.145}"
    },
    // Skip requests from the Watcher Probe in prd02
    // These IPs were found in Watcher Probe logs and CloudFlare blocked logs
    {
      action      = "skip"
      description = "Allow Watcher Probe IPs"
      expression  = "ip.src in {3.75.35.43 3.127.154.57 18.197.137.114}"
    },
    // This block is to block all traffic that is not from Zscaler
    {
      action      = "block"
      description = "Allow Zscaler Only"
      expression  = "(not ip.src in {52.57.217.97 3.79.78.24} and http.request.uri.path ne \"/google-emm/notifications\" and http.request.uri.path ne \"/.well-known/jwks.json\")"
    },
  ]
}
