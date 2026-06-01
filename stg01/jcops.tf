####################################################
# stg01.jcops.net - Router Zone for Staging (parallel to stg01.jumpcloud.com)
#
# Mirrors all proxied DNS entries for the stg01 environment.
# These records were originally proxied in stg01.jumpcloud.com
# (now managed via infra-edge CloudFront distributions).
# Each record points to the stg01-use2.jcplatform.dev origin.
#
# See: https://jumpcloud.atlassian.net/browse/TE-2005
####################################################

locals {
  jcops_zone_name = "stg01.jcops.net"

  jcops_dns_records = [
    {
      name    = "api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist.stg01-use2.jcplatform.dev"
    },
    {
      name    = "catalog"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "data-catalog.stg01-use2.jcplatform.dev"
    },
    {
      name    = "console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console.stg01-use2.jcplatform.dev"
    },
    {
      name    = "go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go.stg01-use2.jcplatform.dev"
    },
    {
      name    = "jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpdesk.stg01-use2.jcplatform.dev"
    },
    {
      name    = "kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public.stg01-use2.jcplatform.dev"
    },
    {
      name    = "login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "login-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "login-api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "mcp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "mcp.stg01-use2.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm.stg01-use2.jcplatform.dev"
    },
    {
      name    = "nli"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "nli.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.nli"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "nli.stg01-use2.jcplatform.dev"
    },
    {
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth.stg01-use2.jcplatform.dev"
    },
    {
      name    = "password-manager"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "password-manager.stg01-use2.jcplatform.dev"
    },
    {
      name    = "saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "saas.stg01-use2.jcplatform.dev"
    },
    {
      name    = "ssf"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "saas.stg01-use2.jcplatform.dev"
    },
    {
      name    = "slack"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "slack.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.slack"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "slack.stg01-use2.jcplatform.dev"
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso.stg01-use2.jcplatform.dev"
    },
    {
      name    = "*.sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso.stg01-use2.jcplatform.dev"
    },
    {
      name    = "ai"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "ai.stg01-use2.jcplatform.dev"
    },
    {
      name    = "ocsp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "ocsp.stg01-use2.jcplatform.dev"
    },
  ]
}

resource "cloudflare_zone" "jcops_net" {
  account_id = local.cloudflare_account
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = local.jcops_zone_name
}

resource "cloudflare_total_tls" "jcops_net" {
  zone_id               = cloudflare_zone.jcops_net.id
  enabled               = true
  certificate_authority = "lets_encrypt"
}

module "jcops_dns" {
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=3.1.0"
  zone_id       = cloudflare_zone.jcops_net.id
  zone_name     = local.jcops_zone_name
  dns_records   = local.jcops_dns_records
  ns_delegation = []
}

module "jcops_security" {
  source = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.7.0"

  zone_id                                   = cloudflare_zone.jcops_net.id
  additional_ratelimit_rules                = []
  additional_waf_rules                      = []
  cloudflare_managed_ruleset_rule_overrides = local.managed_ruleset_overrides
}

module "jcops_settings" {
  source           = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id          = cloudflare_zone.jcops_net.id
  always_use_https = "off"
}
