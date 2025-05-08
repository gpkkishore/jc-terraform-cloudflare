locals {
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
      name    = "adbridge-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-kickstart-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "adbridge.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "admin-oauth.id.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "agent.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "agent-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "api.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "assist.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "assist-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "apple-mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "bss.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "si-bss-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "console.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "console-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "device-cert.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "kickstart.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "apple.mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "go.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "go-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "private-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "jumpdesk.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpdesk-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "login.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "login-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "mulesoft-api.prd02"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "jumpcloud-prod-dlb.lb.anypointdns.net"
    },
    {
      name    = "nli.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli-haproxy-haproxy.ue1-prd-p01.jcplatform.dev"
    },
    {
      name    = "oauth.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "oauth.id.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "devices.pwm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "grpc.pwm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "scim.pwm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "sso.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "saas.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "trampoline.id.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.adbridge-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-kickstart-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.adbridge.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.admin-oauth.id.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.agent.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "agent-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.api.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.assist.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "assist-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.apple-mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.console.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "console-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.device-cert.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.kickstart.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.apple.mdm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.go.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "go-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.private-kickstart.prd02"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.jumpdesk.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpdesk-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.login.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "login-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.nli.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli-haproxy-haproxy.ue1-prd-p01.jcplatform.dev"
    },
    {
      name    = "*.oauth.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.oauth.id.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.devices.pwm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.grpc.pwm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.scim.pwm.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "pwm-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.sso.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.saas.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"
    },
    {
      name    = "*.trampoline.id.prd02"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "identity-haproxy.prd02-euc1-p00.jcplatform.dev"
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



  # TODO: Add custom edge certs for the prd02 records, once they are created

  # /**
  #  * Custom Certificates for the prd02 environment
  #  */
  # custom_certs = [
  #   {
  #     name              = "microsoft-mdm"
  #     hosts             = ["microsoft-mdm.prd02.jumpcloud.com", "*.microsoft-mdm.prd02.jumpcloud.com"]
  #     validation_method = "txt"
  #   },
  #   {
  #     name              = "apple.mdm"
  #     hosts             = ["apple.mdm.prd02.jumpcloud.com", "*.apple.mdm.prd02.jumpcloud.com"]
  #     validation_method = "txt"
  #   },
  #   {
  #     name              = "pwm"
  #     hosts             = ["pwm.prd02.jumpcloud.com", "*.pwm.prd02.jumpcloud.com"]
  #     validation_method = "txt"
  #   },
  #   {
  #     name              = "id"
  #     hosts             = ["id.prd02.jumpcloud.com", "*.id.prd02.jumpcloud.com"]
  #     validation_method = "txt"
  #   },
  # ]
}
