####################################################
# jcops.net - Primary Router Zone (parallel to jumpcloud.com)
#
# Brand oranges retired to infra-edge → jcops_app_dns_records (explicit; stg01/prd03 pattern).
# Remaining proxied brand rows in prd/data_prd.tf → jcops_mirrored_dns_records.
# Vault / id child zones: separate mirror locals below.
#
# See: https://jumpcloud.atlassian.net/browse/TE-2005
# ST-02 (TE-2006): proxied * catch-all and routing-edge-fallback structural DNS.
# Zone Custom Hostnames fallback origin (prepares TE-2015); not Custom Hostname objects.
####################################################

locals {
  jcops_zone_name = "jcops.net"

  jcops_router_structural_dns_records = [
    {
      name    = "*"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud.com"
    },
    {
      name    = "routing-edge-fallback"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "status.jumpcloud.com"
    },
  ]

  # EU app labels (api.eu, etc.) live in eu.jcops.net as api — do not duplicate on parent jcops.net.
  prd_eu_jcops_record_names = toset([for r in local.prd_eu_records : r.name])

  # Explicit jcops.net origins for brand rows retired from data_prd (stg01/prd03 jcops_app_dns_records pattern).
  # module.jcops_dns ref 2.0.1 reads value (not content); stg01 uses dns module 3.1.0 + provider 4.52+.
  jcops_app_dns_records = [
    {
      name    = "ai"
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "35.241.16.49" # GCP LB prd — proxied-A custom origin for ai.jumpcloud.com CH
    },
    {
      name    = "ti-1"
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "16.144.165.16" # TE-2410: JC-Corporate-TI-1 (us-west-2); was Bitnami 44.239.47.105
    },
    {
      name    = "ti-2"
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "35.166.236.151" # TE-2410: JC-Corporate-TI-2 (us-west-2); was Bitnami 52.13.15.220
    },
    {
      name    = "*.apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm.prd-use1.jcplatform.dev"
    },
    {
      name    = "api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "api.prd-use1.jcplatform.dev"
    },
    {
      name    = "apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.prd-use1.jcplatform.dev"
    },
    {
      name    = "assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "assist.prd-use1.jcplatform.dev"
    },
    {
      name    = "console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "console.prd-use1.jcplatform.dev"
    },
    # TE-2250: sGTM Lightsail Container Service (Titanium). Brand grey→jcops in infra-edge.
    {
      name    = "corporate-edge"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "corporate-edge.0f5mswsdrze1t.us-east-1.cs.amazonlightsail.com"
    },
    {
      name    = "go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "go.prd-use1.jcplatform.dev"
    },
    {
      name    = "jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpdesk.prd-use1.jcplatform.dev"
    },
    {
      name    = "kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public.prd-use1.jcplatform.dev"
    },
    {
      name    = "login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "login-api.prd-use1.jcplatform.dev"
    },
    {
      name    = "mcp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "mcp.prd-use1.jcplatform.dev"
    },
    {
      name    = "usermcp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "usermcp.prd-use1.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm.prd-use1.jcplatform.dev"
    },
    {
      name    = "nli"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli.prd-use1.jcplatform.dev"
    },
    {
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth.prd-use1.jcplatform.dev"
    },
    {
      name    = "ocsp"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "ocsp.prd-use1.jcplatform.dev"
    },
    {
      name    = "polaris"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "polaris.prd-use1.jcplatform.dev"
    },
    {
      name    = "polaris-console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "polaris-console.prd-use1.jcplatform.dev"
    },
    {
      name    = "saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "saas.prd-use1.jcplatform.dev"
    },
    {
      name    = "scep"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "ocsp.prd-use1.jcplatform.dev"
    },
    {
      name    = "slack"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "slack.prd-use1.jcplatform.dev"
    },
    {
      name    = "ssf"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "saas.prd-use1.jcplatform.dev"
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso.prd-use1.jcplatform.dev"
    },
    {
      name    = "trino"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "trino.prd-use1.jcplatform.dev"
    },
  
    # Marketing/third-party orange origins (master #920); brand rows grey→jcops in data_prd.tf
{
      name    = "community"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "zsupw73743.lithium.com"
    },
{
      name    = "support"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "support.jumpcloud.com.00dg0000000jusyma2.live.siteforce.com"
    },
{
      name    = "www"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "d3d61011c209cf0c2b83e5959e49829c-330411615.us-east-1.elb.amazonaws.com"
    },
]

  jcops_app_dns_record_names = toset([for r in local.jcops_app_dns_records : r.name])

  # Filter: only proxied app records from jumpcloud.com (exclude apex @; jcops.net is its own zone).
  jcops_mirrored_dns_records = [
    for r in local.prd_dns_records : r
    if lookup(r, "proxied", false) == true &&
    lookup(r, "name", "") != "@" &&
    !contains(local.jcops_app_dns_record_names, lookup(r, "name", "")) &&
    !contains(local.prd_eu_jcops_record_names, lookup(r, "name", ""))
  ]

  # Proxied vault.jumpcloud.com production rows → jcops.net (TE-2005).
  # Source list: data/vault_jcops_mirror_us.tf (parity-checked against prd/data_additional.tf).
  vault_jumpcloud_jcops_mirror_records = [
    for r in local.vault_jumpcloud_proxied_source_records : merge(r, {
      name = trimsuffix(
        replace(
          contains(["@", local.vault_jumpcloud_child_zone], r.name) ? local.vault_jumpcloud_child_zone : r.name,
          ".jumpcloud.com",
          ".jcops.net",
        ),
        ".${local.jcops_zone_name}",
      )
    })
  ]

  # id.jumpcloud.com: prd/id_jcops_mirror_us.tf (not in brand mirror).
  jcops_dns_records = concat(
    local.jcops_router_structural_dns_records,
    local.jcops_mirrored_dns_records,
    local.jcops_app_dns_records,
    local.vault_jumpcloud_jcops_mirror_records,
    local.id_jumpcloud_jcops_mirror_records,
  )

  jcops_add_waf_rules = concat(local.add_waf_rules["jumpcloud.com"], local.add_waf_rules["id.jumpcloud.com"], local.add_waf_rules["vault.jumpcloud.com"])

  jcops_add_ratelimit_rules = local.add_ratelimit_rules["jumpcloud.com"]
}

resource "cloudflare_zone" "jcops_net" {
  account_id = local.account_id
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
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=2.0.1"
  zone_id       = cloudflare_zone.jcops_net.id
  zone_name     = local.jcops_zone_name
  dns_records   = local.jcops_dns_records
  ns_delegation = local.jcops_child_ns_delegation_records
}

resource "cloudflare_custom_hostname_fallback_origin" "jcops_router" {
  zone_id = cloudflare_zone.jcops_net.id
  origin  = "routing-edge-fallback.${local.jcops_zone_name}"

  depends_on = [module.jcops_dns]
}

module "jcops_security" {
  source                     = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.6.0"
  zone_id                    = cloudflare_zone.jcops_net.id
  additional_ratelimit_rules = local.jcops_add_ratelimit_rules
  additional_waf_rules       = concat(local.cve_2026_111497_waf_rules, local.jcops_add_waf_rules)
}

module "jcops_settings" {
  source           = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id          = cloudflare_zone.jcops_net.id
  always_use_https = "off"
}
