resource "cloudflare_zone" "cloudflare_zone_resource" {
  account_id = local.cloudflare_account
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

module "dns" {
  source        = "app.terraform.io/jumpcloud/dns/cloudflare"
  version       = "2.0.1"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.prd02_dns_records
  ns_delegation = local.prd02_ns_delegation_records
}

module "security" {
  source  = "app.terraform.io/jumpcloud/security/cloudflare"
  version = "3.0.1"

  zone_id                    = cloudflare_zone.cloudflare_zone_resource.id
  additional_ratelimit_rules = local.add_ratelimit_rules
  additional_waf_rules       = local.add_waf_rules
}

module "settings" {
  source  = "app.terraform.io/jumpcloud/zone-settings/cloudflare"
  version = "2.0.2"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

# locals {
#   identity_security_response_headers = [
#     {
#       name  = "X-Content-Type-Options"
#       value = "no-sniff"
#     },
#     {
#       name  = "X-Frame-Options"
#       value = "DENY"
#     },
#     {
#       name  = "Strict-Transport-Security"
#       value = "max-age=86400; includeSubdomains; preload"
#     },
#     {
#       name  = "Content-Security-Policy"
#       value = "default-src 'self'; script-src 'unsafe-hashes' 'sha256-FRuPMoCm2v334i+3oP3jLBT4RnmwV1pycDQaxVXK4MY=';"
#     }
#   ]

#   header_name_to_identity_security_response_header_value = { for this in local.identity_security_response_headers : this.name => this.value }
# }

# resource "cloudflare_ruleset" "security_response_headers" {
#   zone_id = data.cloudflare_zone.id_stg01_jumpcloud_com.id
#   name    = "Security Response Header Modifications"
#   kind    = "zone"
#   phase   = "http_response_headers_transform"

#   rules {
#     description = "HTTP Response Header Security Modification Rules for domains within the id.prd02.jumpcloud.com zone"
#     expression  = "(ends_with(http.host, \".id.prd02.jumpcloud.com\"))"
#     enabled     = true
#     action      = "rewrite"

#     action_parameters {
#       dynamic "headers" {
#         for_each = local.header_name_to_identity_security_response_header_value

#         content {
#           operation = "add"
#           name      = headers.key
#           value     = headers.value
#         }
#       }
#     }
#   }
# }
