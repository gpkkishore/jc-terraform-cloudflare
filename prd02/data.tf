locals {
  aws_account        = "767397867240"
  cloudflare_account = "3c96d914c0eaa62b7b4c9960e63818f7"

  /**
   * DNS A records for the prd02 environment
   */
  prd02_a_records = []

  /**
   * DNS CNAME records for the prd02 environment
   */
  prd02_mx_records = []

  /**
   * DNS MX records for the prd02 environment
   */
  prd02_cname_records = [
    {
      name    = "adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-kickstart-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "admin-oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "apple-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "si-bss-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go-haproxy.prd02-euc1-p00.jcplatform.dev"
    },

    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpdesk-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "login-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "mulesoft-api",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      content = "jumpcloud-prod-dlb.lb.anypointdns.net"
    },
    {
      name    = "nli"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "nli-haproxy-haproxy.ue1-prd-p01.jcplatform.dev"
    },
    {
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "devices.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "grpc.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "scim.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "saas-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "trampoline.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-kickstart-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.admin-oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.apple-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },

    {
      name    = "*.go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go-haproxy.prd02-euc1-p00.jcplatform.dev"
    },

    {
      name    = "*.private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpdesk-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "login-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.nli"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "nli-haproxy-haproxy.ue1-prd-p01.jcplatform.dev"
    },
    {
      name    = "*.oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.devices.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.grpc.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.scim.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "saas-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.trampoline.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    }
  ]

  /**
   * DNS miscellaneous records for the prd02 environment
   */
  prd02_misc_records = []

  /**
   * Aggregate of all DNS records for the prd02 environment
   */
  prd02_dns_records = concat(local.prd02_a_records, local.prd02_cname_records, local.prd02_mx_records, local.prd02_misc_records)

  /**
   * NS delegation records for the prd02 environment
   * This can be used to delegate subdomains to other DNS providers or other cloudflare zones
   */
  prd02_ns_delegation_records = [
    {
      name    = "ldap"
      ttl     = 300
      content = ["ns-1698.awsdns-20.co.uk.", "ns-386.awsdns-48.com.", "ns-918.awsdns-50.net.", "ns-1457.awsdns-54.org."]
    },
    {
      name    = "ldap-mfa"
      ttl     = 300
      content = ["ns-1147.awsdns-15.org.", "ns-1901.awsdns-45.co.uk.", "ns-52.awsdns-06.com.", "ns-747.awsdns-29.net."]
    },
  ]

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
      expression  = "(not ip.src in {52.57.217.97 3.79.78.24})"
    },
    {
      action      = "block"
      description = "IR-177-block-tan-stork-incident"
      expression  = "(ip.src in {2804:1b2:82:7c21:d294:66ff:febb:ff7 105.105.63.193 51.79.55.221 2607:5300:201:3100::3381})"
    },
  ]

}
