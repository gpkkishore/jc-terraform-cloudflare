locals {
  aws_account        = "330105897241"
  cloudflare_account = "3c96d914c0eaa62b7b4c9960e63818f7"
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

module "dns" {
  source        = "app.terraform.io/jumpcloud/dns/cloudflare"
  version       = "1.0.7"
  zone_id       = cloudflare_zone.cloudflare_zone_resource.id
  zone_name     = var.zone_name
  dns_records   = local.stg01_dns_records
  ns_delegation = local.stg01_ns_delegation_records
}

module "security" {
  source  = "app.terraform.io/jumpcloud/security/cloudflare"
  version = "1.0.22"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

module "settings" {
  source  = "app.terraform.io/jumpcloud/zone-settings/cloudflare"
  version = "1.0.4"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

resource "aws_route53_zone" "r53_delegated_zone" {
  for_each = toset(local.r53_zones)
  name     = each.key
}

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

# Page rules for console.{zone_name}/*, e.g. console.jumpcloud.com/*
# Note: Browser check is disabled for the console endpoint only on awsstg so acceptance tests don't get blocked
resource "cloudflare_page_rule" "console_api_page_rule" {
  zone_id  = cloudflare_zone.cloudflare_zone_resource.id
  target   = "*console.${var.zone_name}/*"
  priority = 1

  actions {
    # Turn off Browser Integrity Check for /api requests
    browser_check = "off"
  }
}

# Disable BIC for go.stg01.jumpcloud.com endpoint and jumpcloudgo/go-http-cliet agent
resource "cloudflare_ruleset" "disable_bic_go_jumpcloud_com" {
  zone_id     = cloudflare_zone.cloudflare_zone_resource.id
  name        = "Disable BIC for go.stg01.jumpcloud.com"
  description = "Disable BIC for go.stg01.jumpcloud.com"
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
    expression  = "(http.host eq \"go.stg01.jumpcloud.com\" and http.user_agent contains \"go-http-client\") or (http.host eq \"go.stg01.jumpcloud.com\" and http.user_agent contains \"JumpCloudGo\")"
    description = "Disable BIC for go.stg01.jumpcloud.com with JumpCloudGo and go-http-client agent"
    enabled     = true
  }
}

data "cloudflare_zone" "id_stg01_jumpcloud_com" {
  account_id = local.cloudflare_account
  name       = "id.stg01.jumpcloud.com"
}

locals {
  security_response_headers = [
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
      value = "default-src 'self'; img-src cdn03.jumpcloud.com; script-src cdn03.jumpcloud.com 'sha256-wTqndRW5YDR1N+bsSGclZKeAl9oJDAX5Wd1zkpZ3qyI='; style-src cdn03.jumpcloud.com 'sha256-NeDMjPoMnqu1i4sLqseIeRNH1FAdG4p//iQlF5uUQUQ='"
    }
  ]

  header_name_to_security_response_header = { for this in local.security_response_headers : this.name => this.value }
}

resource "cloudflare_ruleset" "security_response_headers" {
  zone_id     = data.cloudflare_zone.id_stg01_jumpcloud_com.id
  name        = "Security Header Modifications"
  description = "Security Header Modifications"
  kind        = "zone"
  phase       = "http_response_headers_transform"

  rules {
    description = "HTTP Response Header Security Modification Rules"
    expression  = "endswith(http.host, \".id.stg01.jumpcloud.com\")"
    enabled     = true
    action      = "rewrite"

    action_parameters {
      dynamic "headers" {
        for_each = local.header_name_to_security_response_header

        content {
          operation = "add"
          name      = headers.key
          value     = headers.value
        }
      }
    }
  }
}
