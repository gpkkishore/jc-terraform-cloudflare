##### Stg01 Cloudflare API Token for terraform-clouflare Spacelift Stack
resource "cloudflare_api_token" "stg01-spacelift" {
  name = "terraform-cloudflare/stg01-spacelift-${local.time}"
  policies = [
    {
      effect = "allow"
      permission_groups = [
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
          id = local.zone_permission_group_ids["Firewall Services Write"]
        },
        {
          id = local.zone_permission_group_ids["DNS Write"]
        },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.zone.${local.zone_ids["id.stg01.jumpcloud.com"]}" = "*"
        "com.cloudflare.api.account.zone.${local.zone_ids["stg01.jumpcloud.com"]}"    = "*"
      })
    }
  ]
  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [random_uuid.uuid.result]
  }
}

data "aws_secretsmanager_secret" "cloudflare-stg01-api-token" {
  name = "control/cloudflare/stg01/api-token"
}

resource "aws_secretsmanager_secret_version" "cloudflare-stg01-api-token" {
  secret_id = data.aws_secretsmanager_secret.cloudflare-stg01-api-token.id
  secret_string = jsonencode({
    api_token = cloudflare_api_token.stg01-spacelift.value
  })
}

resource "spacelift_context" "stg01-cloudflare" {
  description = "Stg01 Cloudflare API Token"
  name        = "stg01-cloudflare"
  space_id    = local.env_spaces["stg01"]
  labels      = ["autoattach:stg01-cloudflare"]
}

resource "spacelift_environment_variable" "stg01-cloudflare_api_token" {
  context_id = spacelift_context.stg01-cloudflare.id
  name       = "TF_VAR_cloudflare_api_token"
  value      = cloudflare_api_token.stg01-spacelift.value
}

import {
  to = spacelift_context.stg01-cloudflare
  id = "stg01-cloudflare"
}


####  Stg01 Cloudfront Cloudflare API Token for terraform-cloudfront Spacelift Stack

resource "cloudflare_api_token" "stg01-cloudfront" {
  name = "terraform-cloudfront/stg01-spacelift-${local.time}"
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
          id = local.zone_permission_group_ids["Logs Write"]
        },
        {
          id = local.zone_permission_group_ids["Firewall Services Write"]
        },
        {
          id = local.zone_permission_group_ids["DNS Write"]
        },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.zone.${local.zone_ids["stg01.jumpcloud.com"]}" = "*"
      })
    }
  ]
  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [random_uuid.uuid.result]
  }
}

data "aws_secretsmanager_secret" "stg01-cloudfront-cloudflare-api-token" {
  name = "control/cloudfront/stg01/cloudflare-api-token"
}

resource "aws_secretsmanager_secret_version" "stg01-cloudfront-cloudflare-api-token" {
  secret_id = data.aws_secretsmanager_secret.stg01-cloudfront-cloudflare-api-token.id
  secret_string = jsonencode({
    api_token = cloudflare_api_token.stg01-cloudfront.value
  })
}

resource "spacelift_context" "stg01-cloudfront-cloudflare-api-token" {
  description = "Stg01 Cloudfront's Cloudflare API Token"
  name        = "stg01-cloudfront"
  space_id    = local.edge_spaces["edge-stg01"]
  labels      = ["autoattach:stg01-cloudfront"]
}

resource "spacelift_environment_variable" "stg01-cloudfront-cloudflare-api-token" {
  context_id = spacelift_context.stg01-cloudfront-cloudflare-api-token.id
  name       = "TF_VAR_cloudflare_api_token"
  value      = cloudflare_api_token.stg01-cloudfront.value
}

import {
  to = spacelift_context.stg01-cloudfront-cloudflare-api-token
  id = "stg01-cloudfront"
}

##### Stg01 edge-tenancy-org-events-processor Cloudflare API Token

resource "cloudflare_api_token" "stg01-use2-edge-tenancy" {
  name = "stg01-use2-edge-tenancy-org-events-processor-${local.time}"
  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          id = local.acct_permission_group_ids["Workers KV Storage Write"]
        }
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.*" = "*"
      })
    }
  ]
  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [random_uuid.uuid.result]
  }
}

data "aws_secretsmanager_secret" "stg01-use2-edge-tenancy-cloudflare-api-token" {
  provider = aws.stg01
  name     = "stg01/edge-tenancy/manual_secrets/cloudflare_api_token"
}

resource "aws_secretsmanager_secret_version" "stg01-use2-edge-tenancy-cloudflare-api-token" {
  provider  = aws.stg01
  secret_id = data.aws_secretsmanager_secret.stg01-use2-edge-tenancy-cloudflare-api-token.id
  secret_string = jsonencode({
    token = cloudflare_api_token.stg01-use2-edge-tenancy.value
  })
}
