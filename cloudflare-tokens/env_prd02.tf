##### Prd02 Cloudflare API Token for terraform-clouflare Spacelift Stack
resource "cloudflare_api_token" "prd02-spacelift" {
  name = "terraform-cloudflare/prd02-spacelift-${local.time}"
  policies = [
    {
      effect = "allow"
      permission_groups = [
        {
          id = local.zone_permission_group_ids["Config Settings Write"]
        },
        {
          id = local.zone_permission_group_ids["Origin Write"]
        },
        {
          id = local.zone_permission_group_ids["Managed headers Write"]
        },
        {
          id = local.zone_permission_group_ids["HTTP DDoS Managed Ruleset Write"]
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
      resources = jsonencode({
        "com.cloudflare.api.account.zone.*" = "*"
      })
    },
    {
      effect = "allow"
      permission_groups = [
        {
          id = local.acct_permission_group_ids["Billing Write"]
        },
        {
          id = local.acct_permission_group_ids["Account Settings Write"]
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

data "aws_secretsmanager_secret" "cloudflare-prd02-api-token" {
  name = "control/cloudflare/prd02/api-token"
}

resource "aws_secretsmanager_secret_version" "cloudflare-prd02-api-token" {
  secret_id = data.aws_secretsmanager_secret.cloudflare-prd02-api-token.id
  secret_string = jsonencode({
    api_token = cloudflare_api_token.prd02-spacelift.value
  })
}

resource "spacelift_context" "prd02-cloudflare" {
  description = "Prd02 Cloudflare API Token"
  name        = "prd02-cloudflare"
  space_id    = local.edge_spaces["edge-prd02"]
  labels      = ["autoattach:prd02-cloudflare"]
}

resource "spacelift_environment_variable" "prd02-cloudflare_api_token" {
  context_id = spacelift_context.prd02-cloudflare.id
  name       = "TF_VAR_cloudflare_api_token"
  value      = cloudflare_api_token.prd02-spacelift.value
}

import {
  to = spacelift_context.prd02-cloudflare
  id = "prd02-cloudflare"
}


##### prd02 edge-tenancy-org-events-processor Cloudflare API Token

resource "cloudflare_api_token" "prd02-euc1-edge-tenancy" {
  name = "prd02-euc1-edge-tenancy-org-events-processor-${local.time}"
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

data "aws_secretsmanager_secret" "prd02-euc1-edge-tenancy-cloudflare-api-token" {
  provider = aws.prd02
  name     = "prd02/edge-tenancy/manual_secrets/cloudflare_api_token"
}

resource "aws_secretsmanager_secret_version" "prd02-euc1-edge-tenancy-cloudflare-api-token" {
  provider  = aws.prd02
  secret_id = data.aws_secretsmanager_secret.prd02-euc1-edge-tenancy-cloudflare-api-token.id
  secret_string = jsonencode({
    token = cloudflare_api_token.prd02-euc1-edge-tenancy.value
  })
}
