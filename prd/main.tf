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
  version       = "1.0.6"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.prd_dns_records
  ns_delegation = local.prd_ns_delegation_records
}

module "security" {
  for_each = { for zone in toset(data.cloudflare_zones.production_zones.zones) : zone.id => zone }
  source   = "app.terraform.io/jumpcloud/security/cloudflare"
  version  = "2.1.1"
  zone_id  = each.key
}

module "settings" {
  for_each = { for zone in toset(data.cloudflare_zones.production_zones.zones) : zone.id => zone }
  source   = "app.terraform.io/jumpcloud/zone-settings/cloudflare"
  version  = "1.0.2"
  zone_id  = each.key
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

moved {
  from = cloudflare_record.zercurity_records["MX_zercurity.com_ALT1.ASPMX.L.GOOGLE.COM"]
  to   = cloudflare_record.zercurity_records["MX_zercurity.com_alt1.aspmx.l.google.com"]
}

moved {
  from = cloudflare_record.zercurity_records["MX_zercurity.com_ALT2.ASPMX.L.GOOGLE.COM"]
  to   = cloudflare_record.zercurity_records["MX_zercurity.com_alt2.aspmx.l.google.com"]
}

moved {
  from = cloudflare_record.zercurity_records["MX_zercurity.com_ASPMX.L.GOOGLE.COM"]
  to   = cloudflare_record.zercurity_records["MX_zercurity.com_aspmx.l.google.com"]
}

moved {
  from = cloudflare_record.zercurity_records["MX_zercurity.com_ASPMX2.GOOGLEMAIL.COM"]
  to   = cloudflare_record.zercurity_records["MX_zercurity.com_aspmx2.googlemail.com"]
}

moved {
  from = cloudflare_record.zercurity_records["MX_zercurity.com_ASPMX3.GOOGLEMAIL.COM"]
  to   = cloudflare_record.zercurity_records["MX_zercurity.com_aspmx3.googlemail.com"]
}
