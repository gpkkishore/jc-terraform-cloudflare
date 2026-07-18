locals {
  aws_account        = "569144120012"
  cloudflare_account = "3c96d914c0eaa62b7b4c9960e63818f7"

  /**
   * DNS A records for the prd03 environment
   * Brand ai proxied A retired to infra-edge (ip-origin / cdn-ng this_proxied_a).
   * Prefer state-rm then remove from this list — do not terraform destroy the live record.
   */
  prd03_a_records = []

  /**
   * DNS CNAME records for the prd03 environment
   * All CNAME targets point to prd03-aps1.jcplatform.dev (ap-south-1)
   */
  prd03_mx_records = []

  /**
   * DNS MX records for the prd03 environment
   */
  prd03_cname_records = [
    # Orange brand CNAMEs for infra-edge cdn_list hosts retired — ownership moved to
    # infra-edge module.cdn (migrate_cname + jcops grey cutover). Prefer state-rm then
    # this HCL drop (not destroy). See TheJumpCloud/infra-edge#167.
    # Removed: admin-oauth.id, api, apple-mdm, apple.mdm, assist, console, devices.pwm,
    # go, grpc.pwm, jumpdesk, kickstart, login, mcp, mcpv2, microsoft-mdm, oauth, oauth.id,
    # ocsp, polaris, polaris-console, saas, scep, scim.pwm, slack, sso, trampoline.id, trino
    # (+ matching *. wildcards where present).
    # Commented legacy rows (mulesoft-api, nli) dropped with this cleanup.
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
      name    = "agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "si-bss-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private.prd03-aps1.jcplatform.dev"
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
      name    = "*.agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "agent.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "device-cert.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-private.prd03-aps1.jcplatform.dev"
    },
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
    }
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
