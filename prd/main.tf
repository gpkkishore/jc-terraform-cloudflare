locals {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = "3c96d914c0eaa62b7b4c9960e63818f7"

  # Aggregate of all DNS records
  dns_records = concat(local.prd_dns_records)
}

####################################################
# All Zones
####################################################
data "cloudflare_zones" "production_zones" {
  filter {
    # This creates a regex string that looks like the following: ^dundermifflin\.com|^wuphf\.com|^saber\.com
    match = replace(join("|", formatlist("^%s", concat([var.zone_name], local.cloudflare_zones))), ".", "\\.")
  }
}
module "dns" {
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=2.0.1"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.dns_records
  ns_delegation = local.prd_ns_delegation_records
}

module "security" {
  for_each = { for zone in toset(data.cloudflare_zones.production_zones.zones) : zone.id => zone }
  source   = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.6.0"

  zone_id                    = each.key
  additional_ratelimit_rules = lookup(local.add_ratelimit_rules, each.value.name, [])
  additional_waf_rules       = lookup(local.add_waf_rules, each.value.name, [])
  skip_managed_rulesets      = contains(["vault.jumpcloud.com", "vault.eu.jumpcloud.com"], each.value.name)
}

module "settings" {
  for_each = { for zone in toset(data.cloudflare_zones.production_zones.zones) : zone.id => zone }
  source   = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=v2.0.2"
  zone_id  = each.key
}

####################################################
# Main Zone - jumpcloud.com
####################################################
resource "cloudflare_zone" "cloudflare_zone_resource" {
  account_id = local.account_id
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

# CloudFlare Edge certificates
resource "cloudflare_certificate_pack" "custom_cert_09042024" {
  for_each = { for cert in local.custom_certs : cert.name => cert }

  zone_id                = cloudflare_zone.cloudflare_zone_resource.id
  type                   = "advanced"
  hosts                  = each.value.hosts
  validation_method      = each.value.validation_method
  validity_days          = 90
  certificate_authority  = "google"
  cloudflare_branding    = false
  wait_for_active_status = true
}

# Page Rule for removed microsoft-mdm-configuration-files endpoint in console
resource "cloudflare_page_rule" "console_v2_microsoft_mdm_configuration_files" {
  priority = 1
  target   = "*console.jumpcloud.com/api/v2/microsoft-mdm-configuration-files"
  zone_id  = cloudflare_zone.cloudflare_zone_resource.id
  status   = "disabled"
  actions {
    forwarding_url {
      status_code = 301
      url         = "/"
    }
  }
}

####################################################
# Additional Zones - other domains
####################################################

# Additional zones that may not necessarily have their own workspace or are managed in other repos.
# This allows us to centralize zone creation to one repo and limit permission scope on tokens.
resource "cloudflare_zone" "additional_zone" {
  for_each   = toset(local.cloudflare_zones)
  account_id = local.account_id
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = each.key
}

####################################################
# vault.jumpcloud.com
####################################################
resource "cloudflare_record" "vault_records" {
  for_each = { for record in local.vault_records : "${record.type}_${record.name}_${record.value}" => record }
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  type     = each.value.type
  proxied  = each.value.proxied
  priority = each.value.type == "MX" ? each.value.priority : null
  zone_id  = cloudflare_zone.additional_zone["vault.jumpcloud.com"].id
}

resource "cloudflare_total_tls" "vault_jumpcloud_com" {
  zone_id               = cloudflare_zone.additional_zone["vault.jumpcloud.com"].id
  enabled               = true
  certificate_authority = "lets_encrypt"
}

####################################################
# vault.eu.jumpcloud.com
####################################################
resource "cloudflare_record" "vault_eu_records" {
  for_each = { for record in local.vault_eu_records : "${record.type}_${record.name}_${record.value}" => record }
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  type     = each.value.type
  proxied  = each.value.proxied
  priority = each.value.type == "MX" ? each.value.priority : null
  zone_id  = cloudflare_zone.additional_zone["vault.eu.jumpcloud.com"].id
}

resource "cloudflare_total_tls" "vault_eu_jumpcloud_com" {
  zone_id               = cloudflare_zone.additional_zone["vault.eu.jumpcloud.com"].id
  enabled               = true
  certificate_authority = "lets_encrypt"
}

####################################################
# vault.in.jumpcloud.com
####################################################
resource "cloudflare_record" "vault_in_records" {
  for_each = { for record in local.vault_in_records : "${record.type}_${record.name}_${record.value}" => record }
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  type     = each.value.type
  proxied  = each.value.proxied
  priority = each.value.type == "MX" ? each.value.priority : null
  zone_id  = cloudflare_zone.additional_zone["vault.in.jumpcloud.com"].id
}

resource "cloudflare_total_tls" "vault_in_jumpcloud_com" {
  zone_id               = cloudflare_zone.additional_zone["vault.in.jumpcloud.com"].id
  enabled               = true
  certificate_authority = "lets_encrypt"
}

####################################################
# Resmo
####################################################
locals {
  resmo_zone_name_to_zone = {
    for zone in local.resmo_zones : zone.name => zone
  }
}
module "resmo_dns" {
  source      = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=2.0.1"
  for_each    = local.resmo_zone_name_to_zone
  zone_id     = lookup(cloudflare_zone.additional_zone, each.key).id
  zone_name   = each.key
  dns_records = each.value.dns_records
}

####################################################
# jumpcloudlounge.com
####################################################
resource "cloudflare_record" "jumpcloud_lounge_root_record" {
  depends_on = [cloudflare_zone.additional_zone]

  name    = "@"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "standard-api.prd-use1.jcplatform.dev"
  zone_id = cloudflare_zone.additional_zone["jumpcloudlounge.com"].id
}

resource "cloudflare_record" "jumpcloud_lounge_faux_record" {
  depends_on = [cloudflare_zone.additional_zone]

  name    = "join"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "standard-api.prd-use1.jcplatform.dev"
  zone_id = cloudflare_zone.additional_zone["jumpcloudlounge.com"].id
}

resource "cloudflare_page_rule" "jumpcloud_lounge_page_rule" {
  depends_on = [cloudflare_record.jumpcloud_lounge_faux_record]

  priority = 1
  target   = "*join.jumpcloudlounge.com/*"
  zone_id  = cloudflare_zone.additional_zone["jumpcloudlounge.com"].id
  actions {
    forwarding_url {
      status_code = 301
      url         = "https://jumpcloudlounge.slack.com/join/shared_invite/zt-2kbtelstf-JmeD7I4N1icu69S9TPLIkA#/shared-invite/email"
    }
  }
}

####################################################
# zercurity.com
####################################################
resource "cloudflare_record" "zercurity_records" {
  for_each = { for record in local.zercurity_tmp_records : "${record.type}_${record.name}_${record.value}" => record }
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  type     = each.value.type
  proxied  = each.value.proxied
  priority = each.value.type == "MX" ? each.value.priority : null
  zone_id  = cloudflare_zone.additional_zone["zercurity.com"].id
}

####################################################
# stackidentity.com
####################################################
resource "cloudflare_record" "stackidentity_records" {
  for_each = { for record in local.stackidentity_tmp_records : "${record.type}_${record.name}_${record.value}" => record }
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  type     = each.value.type
  proxied  = each.value.proxied
  priority = each.value.type == "MX" ? each.value.priority : null
  zone_id  = cloudflare_zone.additional_zone["stackidentity.com"].id
}

####################################################
# jumpcloud.ai
####################################################
resource "cloudflare_record" "jumpcloud_ai_records" {
  for_each = { for record in local.jumpcloud_ai_tmp_records : "${record.type}_${record.name}_${record.value}" => record }
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  type     = each.value.type
  proxied  = each.value.proxied
  priority = each.value.type == "MX" ? each.value.priority : null
  zone_id  = cloudflare_zone.additional_zone["jumpcloud.ai"].id
}

resource "cloudflare_page_rule" "jumpcloud_ai_rule" {
  depends_on = [cloudflare_record.jumpcloud_ai_records]

  priority = 1
  target   = "*jumpcloud.ai/*"
  zone_id  = cloudflare_zone.additional_zone["jumpcloud.ai"].id
  actions {
    forwarding_url {
      status_code = 301
      url         = "https://jumpcloud.com/support/get-started-jumpcloud-ai-search"
    }
  }
}

####################################################
# id.jumpcloud.com
####################################################

data "cloudflare_zone" "id_jumpcloud_com" {
  account_id = local.account_id
  name       = "id.jumpcloud.com"
}

locals {
  identity_security_response_headers = [
    {
      name  = "X-Content-Type-Options"
      value = "no-sniff"
    },
    {
      name  = "X-Frame-Options"
      value = "DENY"
    },
    {
      name  = "Strict-Transport-Security"
      value = "max-age=86400; includeSubdomains; preload"
    },
    {
      name  = "Content-Security-Policy"
      value = "default-src 'self'; script-src 'unsafe-hashes' 'sha256-FRuPMoCm2v334i+3oP3jLBT4RnmwV1pycDQaxVXK4MY=';"
    }
  ]

  header_name_to_identity_security_response_header_value = { for this in local.identity_security_response_headers : this.name => this.value }
}

# Identity Security Response Headers for proxied cloudflare domains for the id.jumpcloud.com zone
resource "cloudflare_ruleset" "security_response_headers" {
  zone_id = data.cloudflare_zone.id_jumpcloud_com.id
  name    = "Security Response Header Modifications"
  kind    = "zone"
  phase   = "http_response_headers_transform"

  rules {
    description = "HTTP Response Header Security Modification Rules for domains within the id.jumpcloud.com zone"
    expression  = "(ends_with(http.host, \".id.jumpcloud.com\"))"
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
