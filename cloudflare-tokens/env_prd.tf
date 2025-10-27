##### Prd Cloudflare API Token for terraform-clouflare Spacelift Stack
resource "cloudflare_api_token" "prd-spacelift" {
  name = "terraform-cloudflare/prd-spacelift-${local.time}"
  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          id = local.zone_permission_group_ids["Config Settings Write"]
        },
        {
          id = local.zone_permission_group_ids["Managed headers Write"]
        },        
        {
          id = local.zone_permission_group_ids["Zone Transform Rules Write"]
        },
        {
          id = local.zone_permission_group_ids["Zone WAF Write"]
        },
        {
          id = local.zone_permission_group_ids["Zone Settings Write"]
        },
        {
          id = local.zone_permission_group_ids["Zone Write"]
        },
        {
          id = local.zone_permission_group_ids["SSL and Certificates Write"]
        },
        {
          id = local.zone_permission_group_ids["Logs Write"]
        },        
        {
          id = local.zone_permission_group_ids["Page Rules Write"]
        },
        {
          id = local.zone_permission_group_ids["Firewall Services Write"]
        },
        {
          id = local.zone_permission_group_ids["DNS Write"]
        },
      ]
        resources = {
            "com.cloudflare.api.account.zone.*" = "*"
        }      
    },
    {
      effect = "allow"
      permission_groups = [
        {
          id = local.acct_permission_group_ids["Mass URL Redirects Write"]
        },
        {
          id = local.acct_permission_group_ids["Billing Write"]
        },
        {
          id = local.acct_permission_group_ids["Account Settings Write"]
        }
      ]
        resources = {
            "com.cloudflare.api.account.${cloudflare_account_id}" = "*"
        }
    }    
  ]
  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [random_uuid.uuid.result]
  }
}

data "aws_secretsmanager_secret" "cloudflare-prd-api-token" {
  name = "control/cloudflare/prd/api-token"
}

resource "aws_secretsmanager_secret_version" "cloudflare-prd-api-token" {
  secret_id = data.aws_secretsmanager_secret.cloudflare-prd-api-token.id
  secret_string = jsonencode({
    api_token = cloudflare_api_token.prd-spacelift.value
  })
}

resource "spacelift_context" "prd-cloudflare" {
  description = "Prd Cloudflare API Token"
  name        = "prd-cloudflare"
  space_id    = local.env_spaces["prd"]
  labels      = ["autoattach:prd-cloudflare"]
}

resource "spacelift_environment_variable" "prd-cloudflare_api_token" {
  context_id = spacelift_context.prd-cloudflare.id
  name       = "TF_VAR_cloudflare_api_token"
  value      = cloudflare_api_token.prd-spacelift.value
}

import {
  to = spacelift_context.prd-cloudflare
  id = "prd-cloudflare"
}


#### Prd Cloudfront Cloudflare API Token for terraform-cloudfront Spacelift Stack

resource "cloudflare_api_token" "prd-cloudfront" {
  name = "terraform-cloudfront/prd-spacelift-${local.time}"
  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          id = local.zone_permission_group_ids["Zone WAF Write"]
        },
        {
          id = local.zone_permission_group_ids["Zone Settings Write"]
        },
        {
          id = local.zone_permission_group_ids["Zone Write"]
        },
        {
          id = local.zone_permission_group_ids["SSL and Certificates Write"]
        },        
        {
          id = local.zone_permission_group_ids["Logs Write"]
        },
        {
          id = local.zone_permission_group_ids["Firewall Services Write"]
        },
        {
          id = local.zone_permission_group_ids["DNS Write"]
        },
      ]
      resources = {
        "com.cloudflare.api.account.zone.${local.zone_ids["jumpcloud.com"]}" = "*"
      }
    }
  ]
  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [random_uuid.uuid.result]
  }
}

data "aws_secretsmanager_secret" "prd-cloudfront-cloudflare-api-token" {
  name = "control/cloudfront/prd/cloudflare-api-token"
}

resource "aws_secretsmanager_secret_version" "prd-cloudfront-cloudflare-api-token" {
  secret_id = data.aws_secretsmanager_secret.prd-cloudfront-cloudflare-api-token.id
  secret_string = jsonencode({
    api_token = cloudflare_api_token.prd-cloudfront.value
  })
}

resource "spacelift_context" "prd-cloudfront-cloudflare-api-token" {
  description = "prd Cloudfront's Cloudflare API Token"
  name        = "prd-cloudfront"
  space_id    = local.edge_spaces["edge-prd"]
  labels      = ["autoattach:prd-cloudfront"]
}

resource "spacelift_environment_variable" "prd-cloudfront-cloudflare-api-token" {
  context_id = spacelift_context.prd-cloudfront-cloudflare-api-token.id
  name       = "TF_VAR_cloudflare_api_token"
  value      = cloudflare_api_token.prd-cloudfront.value
}

import {
  to = spacelift_context.prd-cloudfront-cloudflare-api-token
  id = "prd-cloudfront"
}
