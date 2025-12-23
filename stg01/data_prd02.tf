locals {
  prd02_a_records = []

  prd02_mx_records = []

  prd02_cname_records = [
    {
      name    = "adbridge.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.adbridge.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge.stg01-use2.jcplatform.dev"
    },
    {
      name    = "adbridge-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-kickstart.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.adbridge-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-kickstart.stg01-use2.jcplatform.dev"
    },
    {
      name    = "api.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api.stg01-use2.jcplatform.dev"
    },
    /*     {
      name    = "*.api.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api.stg01-use2.jcplatform.dev"
    }, */
    {
      name    = "apple.mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.apple.mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "assist.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.assist.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist.stg01-use2.jcplatform.dev"
    },
    {
      name    = "bss.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "si-bss-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.bss.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "si-bss-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "catalog.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "data-catalog.stg01-use2.jcplatform.dev"
    },
    {
      name    = "device-cert.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.device-cert.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert.stg01-use2.jcplatform.dev"
    },
    {
      name    = "console.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.console.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "go.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.go.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go.stg01-use2.jcplatform.dev"
    },
    {
      name    = "jumpdesk.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpdesk.stg01-use2.jcplatform.dev"
    },
    {
      name    = "kickstart.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.kickstart.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public.stg01-use2.jcplatform.dev"
    },
    {
      name    = "login.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "login-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.login.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "login-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "mcp.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "mcp.stg01-use2.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "nli.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "nli.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.nli.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "nli.stg01-use2.jcplatform.dev"
    },
    {
      name    = "slack.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "slack.stg01-use2.jcplatform.dev"
    },
    {
      name    = "oauth.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.oauth.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth.stg01-use2.jcplatform.dev"
    },
    {
      name    = "private-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.private-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private.stg01-use2.jcplatform.dev"
    },
    {
      name    = "saas.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "saas.stg01-use2.jcplatform.dev"
    },
    {
      name    = "sso.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.sso.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso.stg01-use2.jcplatform.dev"
    },
    {
      name    = "agent.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.agent.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent.stg01-use2.jcplatform.dev"
    },
    {
      name    = "devices.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "grpc.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.grpc.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "scim.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.scim.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "cdn.pwm.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "d16mcbw7jdbt7n.cloudfront.net"
    },
    {
      name    = "ssf.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "saas.stg01-use2.jcplatform.dev"
    }
  ]

  prd02_misc_records = []

  prd02_dns_records = concat(local.prd02_a_records, local.prd02_cname_records, local.prd02_mx_records, local.prd02_misc_records)
}
