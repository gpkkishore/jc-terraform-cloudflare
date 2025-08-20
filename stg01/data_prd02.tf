locals {
  prd02_a_records = []

  prd02_mx_records = []

  prd02_cname_records = [
    {
      name    = "adbridge.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.adbridge.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge.stg01-use2.jcplatform.dev"
    },
    {
      name    = "adbridge-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-kickstart.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.adbridge-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-kickstart.stg01-use2.jcplatform.dev"
    },
    {
      name    = "api.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "api.stg01-use2.jcplatform.dev"
    },
    /*     {
      name    = "*.api.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "api.stg01-use2.jcplatform.dev"
    }, */
    {
      name    = "apple.mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.apple.mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "assist.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "assist.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.assist.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "assist.stg01-use2.jcplatform.dev"
    },
    {
      name    = "bss.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "si-bss-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.bss.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "si-bss-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "catalog.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "data-catalog.stg01-use2.jcplatform.dev"
    },
    {
      name    = "device-cert.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.device-cert.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert.stg01-use2.jcplatform.dev"
    },
    {
      name    = "console.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.console.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "go.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "go.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.go.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "go.stg01-use2.jcplatform.dev"
    },
    {
      name    = "jumpdesk.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpdesk.stg01-use2.jcplatform.dev"
    },
    {
      name    = "kickstart.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.kickstart.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public.stg01-use2.jcplatform.dev"
    },
    {
      name    = "login.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "login-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.login.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "login-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "mcp.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "mcp.stg01-use2.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "nli.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.nli.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli.stg01-use2.jcplatform.dev"
    },
    {
      name    = "oauth.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.oauth.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth.stg01-use2.jcplatform.dev"
    },
    {
      name    = "private-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.private-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private.stg01-use2.jcplatform.dev"
    },
    {
      name    = "saas.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "saas.stg01-use2.jcplatform.dev"
    },
    {
      name    = "sso.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.sso.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso.stg01-use2.jcplatform.dev"
    },
    {
      name    = "agent.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "agent.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.agent.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "agent.stg01-use2.jcplatform.dev"
    },
    {
      name    = "devices.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.devices.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "grpc.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.grpc.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "scim.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.scim.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "cdn.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d16mcbw7jdbt7n.cloudfront.net"
    },
    {
      name    = "ssf.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "saas.stg01-use2.jcplatform.dev"
    }
  ]

  prd02_misc_records = []

  prd02_dns_records = concat(local.prd02_a_records, local.prd02_cname_records, local.prd02_mx_records, local.prd02_misc_records)
}
