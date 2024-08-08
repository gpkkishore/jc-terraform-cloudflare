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
      value   = "adbridge-kickstart-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "agent-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "assist-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "apple-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "si-bss-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "console-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },

    {
      name    = "go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "go-haproxy.prd02-euc1-p00.jcplatform.dev"
    },

    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpdesk-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "login-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "nli"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli-haproxy-haproxy.ue1-prd-p01.jcplatform.dev"
    },
    {
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "saas-haproxy.prd02-euc1-p00.jcplatform.dev"
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
    # {
    #   name  = "id"
    #   ttl   = 300
    #   value = []
    # },
    # {
    #   name  = "ldap"
    #   ttl   = 300
    #   value = []
    # },
    # {
    #   name  = "ldap-mfa"
    #   ttl   = 300
    #   value = []
    # },
    # {
    #   name  = "pwm"
    #   ttl   = 300
    #   value = []
    # }
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
    // This block is to block all traffic that is not from Zscaler
    {
      action      = "block"
      description = "Allow Zscaler Only"
      expression  = "(not ip.src in {52.57.217.97 3.79.78.24})"
    }
  ]
}
