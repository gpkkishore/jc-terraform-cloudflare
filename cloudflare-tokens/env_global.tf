##### Global Cloudflare API Token for terraform-clouflare Spacelift Stack
resource "cloudflare_api_token" "global-spacelift" {
  name = "terraform-cloudflare/global-spacelift-${local.time}"
  policies = [
    {
      effect = "allow"
      permission_groups = [

        {
          id = local.zone_permission_group_ids["Logs Write"]
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
          id = local.acct_permission_group_ids["Logs Write"]
        },
      ]
      resources = {
        "com.cloudflare.api.account.${local.cloudflare_account_id}" = "*"
      }
    }
  ]
  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [random_uuid.uuid.result]
  }
}

data "aws_secretsmanager_secret" "cloudflare-global-api-token" {
  name = "control/cloudflare/global/api-token"
}

resource "aws_secretsmanager_secret_version" "cloudflare-global-api-token" {
  secret_id = data.aws_secretsmanager_secret.cloudflare-global-api-token.id
  secret_string = jsonencode({
    api_token = cloudflare_api_token.global-spacelift.value
  })
}

resource "spacelift_context" "global-cloudflare" {
  description = "Global Cloudflare API Token"
  name        = "global-cloudflare"
  space_id    = local.edge_spaces["edge-global"]
  labels      = ["autoattach:global-cloudflare"]
}

resource "spacelift_environment_variable" "global-cloudflare_api_token" {
  context_id = spacelift_context.global-cloudflare.id
  name       = "TF_VAR_cloudflare_api_token"
  value      = cloudflare_api_token.global-spacelift.value
}

import {
  to = spacelift_context.global-cloudflare
  id = "global-cloudflare"
}
