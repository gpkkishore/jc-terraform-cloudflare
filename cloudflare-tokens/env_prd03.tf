##### Prd03 Cloudflare API Token for terraform-clouflare Spacelift Stack
resource "cloudflare_api_token" "prd03-spacelift" {
  name = "terraform-cloudflare/prd03-spacelift-${local.time}"
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

data "aws_secretsmanager_secret" "cloudflare-prd03-api-token" {
  name = "control/cloudflare/prd03/api-token"
}

resource "aws_secretsmanager_secret_version" "cloudflare-prd03-api-token" {
  secret_id = data.aws_secretsmanager_secret.cloudflare-prd03-api-token.id
  secret_string = jsonencode({
    api_token = cloudflare_api_token.prd03-spacelift.value
  })
}

resource "spacelift_context" "prd03-cloudflare" {
  description = "Prd03 Cloudflare API Token"
  name        = "prd03-cloudflare"
  space_id    = local.edge_spaces["edge-prd03"]
  labels      = ["autoattach:prd03-cloudflare"]
}

resource "spacelift_environment_variable" "prd03-cloudflare_api_token" {
  context_id = spacelift_context.prd03-cloudflare.id
  name       = "TF_VAR_cloudflare_api_token"
  value      = cloudflare_api_token.prd03-spacelift.value
}


##### prd03 edge-tenancy-org-events-processor Cloudflare API Token

resource "cloudflare_api_token" "prd03-aps1-edge-tenancy" {
  name = "prd03-aps1-edge-tenancy-org-events-processor-${local.time}"
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

data "aws_secretsmanager_secret" "prd03-aps1-edge-tenancy-cloudflare-api-token" {
  provider = aws.prd03
  name     = "prd03/edge-tenancy/manual_secrets/cloudflare_api_token"
}

resource "aws_secretsmanager_secret_version" "prd03-aps1-edge-tenancy-cloudflare-api-token" {
  provider  = aws.prd03
  secret_id = data.aws_secretsmanager_secret.prd03-aps1-edge-tenancy-cloudflare-api-token.id
  secret_string = jsonencode({
    token = cloudflare_api_token.prd03-aps1-edge-tenancy.value
  })
}
