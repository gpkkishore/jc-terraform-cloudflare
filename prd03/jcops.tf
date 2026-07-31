####################################################
# in.jcops.net - Router Zone for India (parallel to prd03.jumpcloud.com)
#
# Cutover app mirrors: jcops_app_dns_records (explicit; brand oranges retired to
# infra-edge). Vault.in mirrors: data/vault_jcops_mirror_in.tf.
# ai proxied A lives here explicitly (ip-origin / proxied-A dance for Custom Hostname).
#
# See: https://jumpcloud.atlassian.net/browse/TE-2005
# ST-02 (TE-2006): proxied * catch-all and routing-edge-fallback structural DNS.
# Zone Custom Hostnames fallback origin (prepares TE-2015); not Custom Hostname objects.
####################################################

locals {
  jcops_zone_name = "in.jcops.net"

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

  # Brand-zone orange CNAMEs retired to infra-edge; keep explicit jcops mirrors
  # so in.jcops.net origins survive (same pattern as stg01 jcops_app_dns_records).
  jcops_app_dns_records = [
    {
      name    = "admin-oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.admin-oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "ai"
      proxied = true
      ttl     = 1
      type    = "A"
      content = "8.232.53.32" # GCP LB prd03 IN — proxied-A dance custom origin for ai.in.jumpcloud.com CH
    },
    {
      name    = "api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "apple-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.apple-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "apple-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "assist.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "console.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "devices.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "go.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "grpc.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.grpc.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "pwm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpdesk.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "jumpdesk.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "kickstart-public.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "login-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.login"
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
    {
      name    = "*.mcp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "usermcp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.usermcp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "microsoft-mdm.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "oauth.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.oauth"
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
      name    = "*.oauth.id"
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
    {
      name    = "polaris"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "polaris.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.polaris"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "polaris.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "polaris-console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "polaris-console.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.polaris-console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "polaris-console.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "scep"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "ocsp.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "scim.pwm"
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
      name    = "slack"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.slack"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "sso.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "trampoline.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.trampoline.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "identity.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "trino"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "trino.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "*.trino"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "trino.prd03-aps1.jcplatform.dev"
    },
    {
      name    = "ssf"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "standard-api.prd03-aps1.jcplatform.dev"
    },
  ]

  # Proxied vault.in child-zone rows → in.jcops.net (TE-2005).
  # Source list: data/vault_jcops_mirror_in.tf (parity-checked against prd/data_additional.tf).
  vault_in_jcops_mirror_records = [
    for r in local.vault_in_proxied_source_records : merge(r, {
      name = trimsuffix(
        replace(
          r.name == "@" ? local.vault_in_child_zone : r.name,
          ".jumpcloud.com",
          ".jcops.net",
        ),
        ".${local.jcops_zone_name}",
      )
    })
  ]

  jcops_dns_records = concat(
    local.jcops_router_structural_dns_records,
    local.jcops_app_dns_records,
    [for r in local.prd03_dns_records : r if lookup(r, "proxied", false) == true],
    local.vault_in_jcops_mirror_records,
  )

  us_east_1_saleseng_ngw        = "52.70.132.28/32"
  aps1_zscaler_natgws           = join(" ", data.aws_ec2_managed_prefix_list.aps1_zscaler_natgws.entries[*].cidr)
  prd03_aps1_c00_natgws         = join(" ", data.aws_ec2_managed_prefix_list.prd03_aps1_c00_natgws.entries[*].cidr)
  vaultone_prd03_aps1_natgws    = "13.235.35.129/32 13.126.24.49/32 3.111.201.28/32"
  vaultone_homolog_mulesoft_ips = "13.216.65.20/32 34.204.246.90/32 54.227.37.138/32 3.216.39.193/32 35.168.81.102/32 54.160.118.35/32 54.165.222.204/32 3.225.136.12/32"

  vaultone_vault_in_allowed_ips = join(" ", [
    local.us_east_1_saleseng_ngw,
    local.prd03_aps1_c00_natgws,
    local.aps1_zscaler_natgws,
    local.vaultone_prd03_aps1_natgws,
    local.vaultone_homolog_mulesoft_ips,
  ])

  vault_in_waf_rules = [
    {
      action      = "skip"
      description = "Allow vault.in.jumpcloud assets (404 page, etc.)"
      expression  = "(http.host eq \"vault.in.jumpcloud.com\" and starts_with(http.request.uri.path, \"/assets\"))"
    },
    {
      action      = "block"
      description = "Blocking Abuse IP's"
      expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213 172.239.50.62 134.199.209.82 2600:3c06:0:0:2000:9fff:feb2:5f63} and http.host contains \"jumpcloud.com\")"
    },
    {
      action      = "block"
      description = "Allow ZScaler only for certain endpoints"
      expression  = format("(http.host eq \"vault.in.jumpcloud.com\" or http.host eq \"app.vault.in.jumpcloud.com\" or http.host eq \"api.vault.in.jumpcloud.com\") and not ip.src in {%s}", local.vaultone_vault_in_allowed_ips)
    },
  ]

  in_jcops_add_waf_rules = concat(local.add_waf_rules, local.vault_in_waf_rules)
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
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=3.0.0"
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
  source                     = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.2.0"
  zone_id                    = cloudflare_zone.jcops_net.id
  additional_ratelimit_rules = local.add_ratelimit_rules
  additional_waf_rules       = local.in_jcops_add_waf_rules
}

module "jcops_settings" {
  source           = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id          = cloudflare_zone.jcops_net.id
  always_use_https = "off"
}

data "aws_ec2_managed_prefix_list" "prd03_aps1_c00_natgws" {
  name = "prd03-aps1-c00-natgws"
}

data "aws_ec2_managed_prefix_list" "aps1_zscaler_natgws" {
  name = "aps1-zscaler-natgws"
}
