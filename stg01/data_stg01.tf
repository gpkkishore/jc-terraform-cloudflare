# See docs/contributing.md for information on how to add a DNS record.
# Note that there are the following arrays, and new records should be placed in the correct array
# stg01_a_records     - All the A, AAAA, and ANAME records
# stg01_mx_records    - All the MX records. MX records MUST be in this array as they have additional attributes
# stg01_cname_records - All the CNAME records
# stg01_misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)
locals {
  r53_zones = []

  stg01_a_records = []

  stg01_mx_records = []

  stg01_cname_records = [
    {
      name    = "adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge.stg01-use2.jcplatform.dev"
    },
    {
      name    = "adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-kickstart.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-kickstart.stg01-use2.jcplatform.dev"
    },
    {
      name    = "api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "api.stg01-use2.jcplatform.dev"
    },
    /*     {
      name    = "*.api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "api.stg01-use2.jcplatform.dev"
    }, */
    {
      name    = "apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "assist.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "assist.stg01-use2.jcplatform.dev"
    },
    {
      name    = "bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "si-bss-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "si-bss-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "catalog"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "data-catalog.stg01-use2.jcplatform.dev"
    },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert.stg01-use2.jcplatform.dev"
    },
    {
      name    = "console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "go.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "go.stg01-use2.jcplatform.dev"
    },
    {
      name    = "jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpdesk.stg01-use2.jcplatform.dev"
    },
    {
      name    = "kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public.stg01-use2.jcplatform.dev"
    },
    {
      name    = "login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "login-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "login-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "nli"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.nli"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli.stg01-use2.jcplatform.dev"
    },
    {
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth.stg01-use2.jcplatform.dev"
    },
    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private.stg01-use2.jcplatform.dev"
    },
    {
      name    = "saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "saas.stg01-use2.jcplatform.dev"
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso.stg01-use2.jcplatform.dev"
    },
    {
      name    = "agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "agent.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "agent.stg01-use2.jcplatform.dev"
    },
    {
      name    = "password-manager"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "password-manager.stg01-use2-p00.jcplatform.dev"
    },
    {
      name    = "devices.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.devices.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "grpc.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.grpc.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "scim.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.scim.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "cdn.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d16mcbw7jdbt7n.cloudfront.net"
    },
    {
      name    = "ssf"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "saas.stg01-use2.jcplatform.dev"
    }
  ]

  stg01_misc_records = []

  stg01_dns_records = concat(local.stg01_a_records, local.stg01_cname_records, local.stg01_mx_records, local.stg01_misc_records)
}
