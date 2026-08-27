####################################################
# stg01.jcops.net - Router Zone for Staging (parallel to stg01.jumpcloud.com)
#
# Mirrors proxied app DNS for stg01 (hand-maintained list; prd/prd02/prd03 mirror dynamically).
# Update jcops_app_dns_records when proxied apps change in infra-edge data_cdn.tf or stg01/data_stg01.tf.
#
# See: https://jumpcloud.atlassian.net/browse/TE-2005
# ST-02 (TE-2006): proxied * catch-all and routing-edge-fallback structural DNS.
# Zone Custom Hostnames fallback origin (prepares TE-2015); not Custom Hostname objects.
####################################################

locals {
  jcops_zone_name = "stg01.jcops.net"

  # Router structural records (TE-2006). More-specific app records take precedence over *.
  jcops_router_structural_dns_records = [
    {
      name    = "*"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpcloud.com"
    },
    {
      name    = "routing-edge-fallback"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "status.jumpcloud.com"
    },
  ]

  jcops_app_dns_records = [
    {
      name    = "api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api.stg01-use2.jcplatform.dev"
    },
    {
      name    = "admin-oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "admin_oauth_id.stg01-use2.jcplatform.dev"
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
      name    = "go"
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
      name    = "login"
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
      name    = "usermcp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "usermcp.stg01-use2.jcplatform.dev"
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
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth.stg01-use2.jcplatform.dev"
    },
    {
      name    = "oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth_id.stg01-use2.jcplatform.dev"
    },
    {
      name    = "password-manager"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "password-manager.stg01-use2.jcplatform.dev"
    },
    {
      name    = "polaris"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "polaris.stg01-use2.jcplatform.dev"
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
      name    = "scep"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "ocsp.stg01-use2.jcplatform.dev"
    },
    {
      name    = "scim-bridge"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "scim-bridge.stg01-use2.jcplatform.dev"
    },
    {
      name    = "slack"
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
      name    = "trampoline.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "trampoline_id.stg01-use2.jcplatform.dev"
    },
    {
      name    = "ai-aws"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "ai.stg01-use2.jcplatform.dev"
    },
    {
      name    = "ai"
      proxied = true
      ttl     = 1
      type    = "A"
      content = "8.228.229.144" # GCP LB STG01 — proxied-A dance custom origin for ai.stg01.jumpcloud.com CH
    },
    {
      name    = "ocsp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "ocsp.stg01-use2.jcplatform.dev"
    },
  ]

  jcops_dns_records = concat(local.jcops_router_structural_dns_records, local.jcops_app_dns_records)

  # TODO: use data blocks to grab these IPs
  vaultone_stg_usw2_natgws      = "44.226.5.239/32 54.71.114.137/32 100.20.42.195/32"
  vaultone_homolog_use1_natgws  = "44.205.147.222/32 3.221.141.250/32 34.199.245.208/32"
  stg01_use2_natgws             = join(" ", data.aws_ec2_managed_prefix_list.stg01_use2_natgws.entries[*].cidr)

  id_stg01_waf_rules = [
      // Allow Salesforce
      // https://help.salesforce.com/s/articleView?id=000384438&type=1
      {
        action      = "skip"
        description = "Allow Salesforce"
        expression  = "(http.host eq \"admin-oauth.id.stg01.jumpcloud.com\" and ip.src in {3.146.43.224/28 13.56.32.176/28 13.58.135.64/28 13.108.0.0/14 34.211.108.32/28 34.226.36.48/28 35.182.14.32/28 66.231.80.0/20 68.232.192.0/20 96.43.144.0/20 128.17.0.0/16 128.245.0.0/16 136.146.0.0/15 198.245.80.0/20 199.122.120.0/21 204.14.232.0/21 3.225.151.145 3.225.240.254/32 18.204.28.162/32 18.211.105.61 34.197.58.108 34.204.111.166/32 52.3.16.30 52.22.251.194 52.70.135.185 155.226.0.0/16})"
      },
      // Allow TestIM IPs
      {
        action      = "skip"
        description = "Allow TestIM"
        expression  = "(http.host in {\"oauth.id.stg01.jumpcloud.com\" \"admin-oauth.id.stg01.jumpcloud.com\" \"trampoline.id.stg01.jumpcloud.com\"} and ip.src in {${join(" ", [for ip in local.testim_ips : ip])}})"
      },
      {
        action      = "block"
        description = "Allow ZScaler only"
        expression  = "(http.host in {\"oauth.id.stg01.jumpcloud.com\" \"admin-oauth.id.stg01.jumpcloud.com\" \"trampoline.id.stg01.jumpcloud.com\"} and not ip.src in {18.190.12.204/32 3.134.71.189/32 3.130.21.136/32 3.23.44.17/32 3.23.121.107/32 ${local.stg01_use2_natgws} ${local.vaultone_stg_usw2_natgws} ${local.vaultone_homolog_use1_natgws} ${local.cicd_self_hosted_runner_natgws}})"
      },
  ]

  stg01_jcops_add_waf_rules = concat(local.add_waf_rules, local.id_stg01_waf_rules)
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

resource "cloudflare_custom_hostname_fallback_origin" "jcops_router" {
  zone_id = cloudflare_zone.jcops_net.id
  origin  = "routing-edge-fallback.${local.jcops_zone_name}"

  depends_on = [module.jcops_dns]
}

module "jcops_security" {
  source = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.7.0"

  zone_id                                   = cloudflare_zone.jcops_net.id
  additional_ratelimit_rules                = local.add_ratelimit_rules
  additional_waf_rules                      = local.stg01_jcops_add_waf_rules
  cloudflare_managed_ruleset_rule_overrides = local.managed_ruleset_overrides
}

module "jcops_settings" {
  source           = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id          = cloudflare_zone.jcops_net.id
  always_use_https = "off"
}

resource "cloudflare_ruleset" "jcops_security_response_headers" {
  zone_id = cloudflare_zone.jcops_net.id
  name    = "Security Response Header Modifications"
  kind    = "zone"
  phase   = "http_response_headers_transform"

  rules {
    description = "HTTP Response Header Security Modification Rules for domains within the id.stg01.jumpcloud.com zone"
    expression  = "(ends_with(http.host, \".id.stg01.jumpcloud.com\"))"
    enabled     = true
    action      = "rewrite"

    action_parameters {
      dynamic "headers" {
        for_each = local.header_name_to_identity_security_response_header_value

        content {
          operation = "add"
          name      = headers.key
          value     = headers.value
        }
      }
    }
  }
}

data "aws_ec2_managed_prefix_list" "stg01_use2_natgws" {
  name = "stg01-use2-natgws"
}
