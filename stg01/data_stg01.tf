# See docs/contributing.md for information on how to add a DNS record.
# Note that there are the following arrays, and new records should be placed in the correct array
# stg01_a_records     - All the A, AAAA, and ANAME records
# stg01_mx_records    - All the MX records. MX records MUST be in this array as they have additional attributes
# stg01_cname_records - All the CNAME records
# stg01_misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)
locals {
  r53_zones = []

  # ai A record retired — infra-edge owns CDN + DNS cutover (state-rm, not destroy)
  stg01_a_records = []

  stg01_mx_records = []

  stg01_cname_records = [
    {
      name    = "adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge.stg01-use2.jcplatform.dev"
    },
    {
      name    = "adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-kickstart.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-kickstart.stg01-use2.jcplatform.dev"
    },
    # {
    #   name    = "ai"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "ai.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "ai-aws"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "ai.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "api"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "api.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.api"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "api.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "apple.mdm"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "apple-mdm.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.apple.mdm"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "apple-mdm.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "assist"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "assist.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.assist"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "assist.stg01-use2.jcplatform.dev"
    # },
    {
      name    = "bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "si-bss-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "si-bss-api.stg01-use2.jcplatform.dev"
    },
    # {
    #   name    = "catalog"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "data-catalog.stg01-use2.jcplatform.dev"
    # },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert.stg01-use2.jcplatform.dev"
    },
    # {
    #   name    = "console"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "console.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.console"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "console.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "go"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "go.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.go"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "go.stg01-use2.jcplatform.dev"
    # },
    {
      name    = "h-9d4953e0122bf"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "h-9d4953e0122bf.stg01-use2.jcplatform.dev"
    },
    # {
    #   name    = "jumpdesk"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "jumpdesk.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "kickstart"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "kickstart-public.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.kickstart"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "kickstart-public.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "login"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "login-api.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.login"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "login-api.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "microsoft-mdm"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "microsoft-mdm.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.microsoft-mdm"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "microsoft-mdm.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "nli"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "nli.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.nli"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "nli.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "oauth"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "oauth.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.oauth"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "oauth.stg01-use2.jcplatform.dev"
    # },
    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private.stg01-use2.jcplatform.dev"
    },
    # {
    #   name    = "saas"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "saas.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "sso"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "sso.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.sso"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "sso.stg01-use2.jcplatform.dev"
    # },
    {
      name    = "agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent.stg01-use2.jcplatform.dev"
    },
    # {
    #   name    = "password-manager"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "password-manager.stg01-use2.jcplatform.dev"
    # },
    {
      name    = "devices.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "grpc.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.grpc.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "polaris-console"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "polaris-console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.polaris-console"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "polaris-console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "trino"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "trino.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.trino"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "trino.stg01-use2.jcplatform.dev"
    },
    {
      name    = "scim.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.scim.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "pwm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "schema-registry"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "schema-registry.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.schema-registry"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "schema-registry.stg01-use2.jcplatform.dev"
    },
    {
      name    = "search-api"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "search-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.search-api"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "search-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "cdn.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "d16mcbw7jdbt7n.cloudfront.net"
    },
    # {
    #   name    = "ssf"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "saas.stg01-use2.jcplatform.dev"
    # },
    # PWM Validation CNAME Record
    {
      name    = "_b81caef9a3b98caf7d41f49d834622c9.pwm.stg01.jumpcloud.com."
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "_cc8d601da3b928d8aaf8829b723c5c96.mqrfdvtdxq.acm-validations.aws."
    },
    {
      name    = "_b265586d8c9ef0c56cfaedb47616c20c.cdn.pwm.stg01.jumpcloud.com."
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "_1387ae55e8aed920cec3cbc91ca8b9e3.mqrfdvtdxq.acm-validations.aws."
    },
    # {
    #   name    = "mcp"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "mcp.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "slack"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "slack.stg01-use2.jcplatform.dev"
    # },
    # {
    #   name    = "*.slack"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "slack.stg01-use2.jcplatform.dev"
    # }
  ]

  stg01_misc_records = []

  stg01_dns_records = concat(local.stg01_a_records, local.stg01_cname_records, local.stg01_mx_records, local.stg01_misc_records)
}
