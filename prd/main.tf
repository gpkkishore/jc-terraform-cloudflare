locals {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = "3c96d914c0eaa62b7b4c9960e63818f7"
}

data "cloudflare_zones" "production_zones" {
  filter {
    # This creates a regex string that looks like the following: ^dundermifflin\.com|^wuphf\.com|^saber\.com
    match = replace(join("|", formatlist("^%s", concat([var.zone_name], local.cloudflare_zones))), ".", "\\.")
  }
}

resource "cloudflare_zone" "cloudflare_zone_resource" {
  account_id = local.account_id
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

# This resource allows for the creation of additional zones that may not necessarily have their own workspace or are managed in other repos.
# This allows us to centralize zone creation to one repo and limit permission scope on tokens
resource "cloudflare_zone" "additional_zone" {
  for_each   = toset(local.cloudflare_zones)
  account_id = local.account_id
  paused     = false
  plan       = var.zone_plan
  type       = "full"
  zone       = each.key
}

module "dns" {
  source        = "app.terraform.io/jumpcloud/dns/cloudflare"
  version       = "2.0.0"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.prd_dns_records
  ns_delegation = local.prd_ns_delegation_records
}

module "security" {
  for_each = { for zone in toset(data.cloudflare_zones.production_zones.zones) : zone.id => zone }
  source   = "app.terraform.io/jumpcloud/security/cloudflare"
  version  = "3.0.0"
  zone_id  = each.key
}

module "settings" {
  for_each = { for zone in toset(data.cloudflare_zones.production_zones.zones) : zone.id => zone }
  source   = "app.terraform.io/jumpcloud/zone-settings/cloudflare"
  version  = "2.0.0"
  zone_id  = each.key
}

# Page Rule for removed microsoft-mdm-configuration-files endpoint in console
resource "cloudflare_page_rule" "console_v2_microsoft_mdm_configuration_files" {
  priority = 2
  target   = "*console.jumpcloud.com/api/v2/microsoft-mdm-configuration-files"
  zone_id  = cloudflare_zone.cloudflare_zone_resource.id
  actions {
    forwarding_url {
      status_code = 301
      url         = "/"
    }
  }
}

# Page rules for console.{zone_name}/api*, e.g. console.jumpcloud.com/api*
resource "cloudflare_page_rule" "console_api_page_rule" {
  zone_id  = cloudflare_zone.cloudflare_zone_resource.id
  target   = "*console.${var.zone_name}/api*"
  priority = 1

  actions {
    # Turn off Browser Integrity Check for /api requests
    browser_check = "off"
  }
}

# Disable BIC for /saml2/metadata endpoint, for Jakarta Commons-HttpClient/3.1 user agent
resource "cloudflare_ruleset" "disable_bic_metadata" {
  zone_id     = cloudflare_zone.cloudflare_zone_resource.id
  name        = "Disable BIC"
  description = "Disable BIC for specific resources"
  kind        = "zone"
  phase       = "http_config_settings"

  rules {
    action = "set_config"
    action_parameters {
      # Note: the https rewrites is a global setting and not needed here,
      # but this ruleset needs at least one setting to true in order to take effect
      automatic_https_rewrites = true
      bic                      = false
    }
    expression  = "(http.request.uri contains \"/saml2/metadata\" and http.user_agent contains \"Jakarta Commons-HttpClient/3.1\") or (http.host eq \"go.jumpcloud.com\" and http.user_agent contains \"go-http-client\") or (http.host eq \"go.jumpcloud.com\" and http.user_agent contains \"JumpCloudGo\")"
    description = "Disable BIC"
    enabled     = true
  }
}


# apple.mdm advanced certificate manager for Let's Encrypt
resource "cloudflare_certificate_pack" "custom_cert" {
  for_each = { for cert in local.custom_certs : cert.name => cert }

  zone_id                = cloudflare_zone.cloudflare_zone_resource.id
  type                   = "advanced"
  hosts                  = each.value.hosts
  validation_method      = each.value.validation_method
  validity_days          = 90
  certificate_authority  = "lets_encrypt"
  cloudflare_branding    = false
  wait_for_active_status = true
}

###########################################
# DNS Configuration for jumpcloudlounge.com
###########################################
resource "cloudflare_record" "jumpcloud_lounge_faux_record" {
  depends_on = [cloudflare_zone.additional_zone]

  name    = "join"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
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
      url         = "https://jumpcloudlounge.slack.com/join/shared_invite/zt-1acbb4zjp-A2zyBCSSUtHnWzAFhCCqNA#/shared-invite/email"
    }
  }
}

################################################
# Temporary Zone configuration for zercurity.com
################################################
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

################################################
# Temporary Zone configuration for jumpcloud.ai
################################################
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

resource "cloudflare_filter" "block_labs_stg01_jumpcloud_ai" {
  zone_id     = cloudflare_zone.additional_zone["jumpcloud.ai"].id
  description = "Filter IP access for labs.stg01.jumpcloud.ai. Staging Egress IPs"
  expression  = "(not ip.src in {3.23.121.107/32 3.23.44.17/32} and http.host eq \"labs.stg01.jumpcloud.ai\")"
}
resource "cloudflare_firewall_rule" "block_labs_stg01_jumpcloud_ai" {
  zone_id     = cloudflare_zone.additional_zone["jumpcloud.ai"].id
  filter_id   = cloudflare_filter.block_labs_stg01_jumpcloud_ai.id
  description = "Block labs.stg01.jumpcloud.ai requests from non-internal IPs"
  action      = "block"
}

resource "cloudflare_filter" "block_jumpcloud_ai" {
  zone_id     = cloudflare_zone.additional_zone["jumpcloud.ai"].id
  description = "Filter IP access for lab.jumpcloud.ai. Prod Egress IPs"
  expression  = "(not ip.src in {34.195.141.99/32 3.226.52.173/32 44.194.86.168/32} and http.host eq \"labs.jumpcloud.ai\")"
}
resource "cloudflare_firewall_rule" "block_jumpcloud_ai" {
  zone_id     = cloudflare_zone.additional_zone["jumpcloud.ai"].id
  filter_id   = cloudflare_filter.block_jumpcloud_ai.id
  description = "Block labs.jumpcloud.ai requests requests from non-internal IPs"
  action      = "block"
}

#################################################################################################
# Identity Security Response Headers for proxied cloudflare domains for the id.jumpcloud.com zone
#################################################################################################

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

# jumpcloud.com
import {
  id = "zone/4024ea03ad001927b18034ed250fb1ec/1335598ed0604553909a9e06368aed08"
  to = cloudflare_ruleset.disable_bic_metadata
}

import {
  id = "zone/4024ea03ad001927b18034ed250fb1ec/fd1b09a696ec4431b35666316087c236"
  to = module.security["4024ea03ad001927b18034ed250fb1ec"].cloudflare_ruleset.custom_waf
}

import {
  id = "zone/4024ea03ad001927b18034ed250fb1ec/e1c8f6047edb468d85242a34cfff12cc"
  to = module.security["4024ea03ad001927b18034ed250fb1ec"].cloudflare_ruleset.rate_limit_http
}

import {
  id = "zone/4024ea03ad001927b18034ed250fb1ec/39cec312e78e48ecb5483726aa99d148"
  to = module.security["4024ea03ad001927b18034ed250fb1ec"].cloudflare_ruleset.zone_level_managed_waf
}

# zercurity.com
import {
  id = "zone/0b0c2ba0e79835513000f86deb23b45d/9f7efcdf40b2450c962231fa790a300d"
  to = module.security["0b0c2ba0e79835513000f86deb23b45d"].cloudflare_ruleset.custom_waf
}

import {
  id = "zone/0b0c2ba0e79835513000f86deb23b45d/0aa05cb0056b42babd8159e5227e99d8"
  to = module.security["0b0c2ba0e79835513000f86deb23b45d"].cloudflare_ruleset.rate_limit_http
}

import {
  id = "zone/0b0c2ba0e79835513000f86deb23b45d/59644c84850c471e8d08c6459af29a41"
  to = module.security["0b0c2ba0e79835513000f86deb23b45d"].cloudflare_ruleset.zone_level_managed_waf
}

# id.jumpcloud.com
import {
  id = "zone/0c4e52db7ee73e0764e3f172f3db47aa/b6f89637db594942a20911271e4fc15d"
  to = cloudflare_ruleset.security_response_headers
}

import {
  id = "zone/0c4e52db7ee73e0764e3f172f3db47aa/e87bb0f798a241539a172110e5de7704"
  to = module.security["0c4e52db7ee73e0764e3f172f3db47aa"].cloudflare_ruleset.custom_waf
}

import {
  id = "zone/0c4e52db7ee73e0764e3f172f3db47aa/f8bd9f2f602147eea4a8f2fa22820263"
  to = module.security["0c4e52db7ee73e0764e3f172f3db47aa"].cloudflare_ruleset.rate_limit_http
}

import {
  id = "zone/0c4e52db7ee73e0764e3f172f3db47aa/37e301fc49944038bf6fe41e4923d309"
  to = module.security["0c4e52db7ee73e0764e3f172f3db47aa"].cloudflare_ruleset.zone_level_managed_waf
}

# id.stg01.jumpcloud.com
import {
  id = "zone/12c2aa5080ada35d58bf854f01b4c213/b8cd77241a5647ac8f190bc7dfa33cf7"
  to = module.security["12c2aa5080ada35d58bf854f01b4c213"].cloudflare_ruleset.custom_waf
}

import {
  id = "zone/12c2aa5080ada35d58bf854f01b4c213/1af0d652bb104b1d9ec6f9a705160caf"
  to = module.security["12c2aa5080ada35d58bf854f01b4c213"].cloudflare_ruleset.rate_limit_http
}

import {
  id = "zone/12c2aa5080ada35d58bf854f01b4c213/1934b5d184af4b568da3386d1486a9f6"
  to = module.security["12c2aa5080ada35d58bf854f01b4c213"].cloudflare_ruleset.zone_level_managed_waf
}

# jumpcloud.ai
import {
  id = "zone/4bb7ca61e6d8f92fe06c04f018d6731d/0975cb92397f41869af289d537d6b325"
  to = module.security["4bb7ca61e6d8f92fe06c04f018d6731d"].cloudflare_ruleset.custom_waf
}

import {
  id = "zone/4bb7ca61e6d8f92fe06c04f018d6731d/92a7184e56f74f64885e4eccdfa6e8a9"
  to = module.security["4bb7ca61e6d8f92fe06c04f018d6731d"].cloudflare_ruleset.rate_limit_http
}

import {
  id = "zone/4bb7ca61e6d8f92fe06c04f018d6731d/287c2cd2bcbe4dcdb8973e710806ebdf"
  to = module.security["4bb7ca61e6d8f92fe06c04f018d6731d"].cloudflare_ruleset.zone_level_managed_waf
}

# jumpcloudlounge.com
import {
  id = "zone/6b2b1191eb33c741203ea7ecb9d3409e/fb70e4ba025940b9b23433ecad0b1ec2"
  to = module.security["6b2b1191eb33c741203ea7ecb9d3409e"].cloudflare_ruleset.custom_waf
}

import {
  id = "zone/6b2b1191eb33c741203ea7ecb9d3409e/8ab0a6f6c85246609200583f8cc5ee94"
  to = module.security["6b2b1191eb33c741203ea7ecb9d3409e"].cloudflare_ruleset.rate_limit_http
}

import {
  id = "zone/6b2b1191eb33c741203ea7ecb9d3409e/bc00e51eae074a129f3ab8953b8bf691"
  to = module.security["6b2b1191eb33c741203ea7ecb9d3409e"].cloudflare_ruleset.zone_level_managed_waf
}
