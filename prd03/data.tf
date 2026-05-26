locals {
  aws_account        = "569144120012"
  cloudflare_account = "3c96d914c0eaa62b7b4c9960e63818f7"

  /**
   * DNS A records for the prd03 environment
   */
  prd03_a_records = [
    // agent0 - GCP Load Balancer IN
    {
      name    = "ai.in",
      proxied = true
      ttl     = 1
      type    = "A"
      content = "8.232.53.32" #TODO: update with the GCP load balancer static IP
    },
  ]

  /**
   * DNS CNAME records for the prd03 environment
   * All CNAME targets point to prd03-aps1.jcplatform.dev (ap-south-1)
   */
  prd03_mx_records = []

  /**
   * DNS MX records for the prd03 environment
   */
  prd03_cname_records = [
    {
      name    = "adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-kickstart.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "admin-oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "apple-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "si-bss-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpdesk.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "login-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "mcp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    # TODO: Confirm if mulesoft-api is needed for prd03 and what the value should be.
    # {
    #   name    = "mulesoft-api",
    #   proxied = false
    #   ttl     = 300
    #   type    = "CNAME"
    #   content = "TBD"
    # },
    # TODO: Confirm if nli is needed for prd03. The prd02 endpoint points to a US-based prd cluster (ue1-prd-p01).
    # {
    #   name    = "nli"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "nli-haproxy-haproxy.ue1-prd-p01.jcplatform.dev"
    # },
    {
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "search-api"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "search-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "schema-registry"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "schema-registry.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "slack"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "devices.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "grpc.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "scim.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "trampoline.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge-kickstart.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "adbridge.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.admin-oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.apple-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpdesk.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "login-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.mcp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    # TODO: Uncomment if nli is deployed to prd03
    # {
    #   name    = "*.nli"
    #   proxied = true
    #   ttl     = 1
    #   type    = "CNAME"
    #   content = "nli-haproxy-haproxy.ue1-prd-p01.jcplatform.dev"
    # },
    {
      name    = "*.search-api"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "search-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.schema-registry"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "schema-registry.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.slack"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.grpc.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.scim.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.trampoline.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "ocsp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "ocsp.prd03-aps1.jcplatform.dev"
    },
  ]

  /**
   * DNS miscellaneous records for the prd03 environment
   */
  prd03_misc_records = []

  /**
   * Aggregate of all DNS records for the prd03 environment
   */
  prd03_dns_records = concat(local.prd03_a_records, local.prd03_cname_records, local.prd03_mx_records, local.prd03_misc_records)

  /**
   * NS delegation records for the prd03 environment
   * This can be used to delegate subdomains to other DNS providers or other cloudflare zones
   *
   * TODO: Update with actual NS values after Route53 hosted zones for ldap.prd03.jumpcloud.com and
   * ldap-mfa.prd03.jumpcloud.com are created (by the infra-layers edge deployment).
   */
  prd03_ns_delegation_records = [
    {
      name    = "vault"
      ttl     = 300
      content = ["anita.ns.cloudflare.com.", "weston.ns.cloudflare.com."]
    },
    {
      name = "radius"
      ttl  = 300
      content = [
        "ns-1845.awsdns-38.co.uk.",
        "ns-881.awsdns-46.net.",
        "ns-125.awsdns-15.com.",
        "ns-1392.awsdns-46.org."
      ]
    },
    {
      name = "ldap"
      ttl  = 300
      content = [
        "ns-1217.awsdns-24.org.",
        "ns-623.awsdns-13.net.",
        "ns-241.awsdns-30.com.",
        "ns-2036.awsdns-62.co.uk."
      ]
    },
    {
      name = "ldap-mfa"
      ttl  = 300
      content = [
        "ns-896.awsdns-48.net.",
        "ns-475.awsdns-59.com.",
        "ns-1339.awsdns-39.org.",
        "ns-1647.awsdns-13.co.uk."
      ]
    },
  ]

  /**
   * Custom Certificates for the prd03 environment
   */
  custom_certs = [
    {
      name              = "microsoft-mdm"
      hosts             = ["microsoft-mdm.in.jumpcloud.com", "*.microsoft-mdm.in.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "apple.mdm"
      hosts             = ["apple.mdm.in.jumpcloud.com", "*.apple.mdm.in.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "pwm"
      hosts             = ["pwm.in.jumpcloud.com", "*.pwm.in.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "id"
      hosts             = ["id.in.jumpcloud.com", "*.id.in.jumpcloud.com"]
      validation_method = "txt"
    },
  ]
}
