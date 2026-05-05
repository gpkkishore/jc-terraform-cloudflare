locals {
  aws_account        = "330105897241"
  cloudflare_account = "3c96d914c0eaa62b7b4c9960e63818f7"

  # Aggregate of all DNS records
  dns_records = concat(local.stg01_dns_records, local.prd02_dns_records)
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = "us-east-2"

  assume_role {
    role_arn = format("arn:aws:iam::%s:role/terraform-admin", local.aws_account)
  }

  default_tags {
    tags = {
      Source      = format("TheJumpCloud/terraform-cloudflare/%s", var.env)
      Team        = "edge"
      CostOrg     = "engineering"
      ProductLine = "shared"
      Env         = var.env
    }
  }
}

resource "cloudflare_zone" "cloudflare_zone_resource" {
  account_id = local.cloudflare_account
  plan       = var.zone_plan
  type       = "full"
  zone       = var.zone_name
}

resource "cloudflare_total_tls" "wildcard_certs" {
  zone_id               = cloudflare_zone.cloudflare_zone_resource.id
  enabled               = true
  certificate_authority = "lets_encrypt"
}

module "dns" {
  source        = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=3.1.0"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.dns_records
  ns_delegation = local.stg01_ns_delegation_records
}

module "security" {
  source = "git@github.com:TheJumpCloud/terraform-cloudflare-security.git?ref=v3.7.0"

  zone_id                                   = cloudflare_zone.cloudflare_zone_resource.id
  additional_ratelimit_rules                = local.add_ratelimit_rules
  additional_waf_rules                      = local.add_waf_rules
  cloudflare_managed_ruleset_rule_overrides = local.managed_ruleset_overrides
}

module "settings" {
  source           = "git@github.com:TheJumpCloud/terraform-cloudflare-zone-settings.git?ref=2.1.0"
  zone_id          = cloudflare_zone.cloudflare_zone_resource.id
  always_use_https = "off"
}

resource "aws_route53_zone" "r53_delegated_zone" {
  for_each = toset(local.r53_zones)
  name     = each.key
}

data "cloudflare_zone" "id_stg01_jumpcloud_com" {
  account_id = local.cloudflare_account
  name       = "id.stg01.jumpcloud.com"
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
  zone_id = data.cloudflare_zone.id_stg01_jumpcloud_com.id
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
