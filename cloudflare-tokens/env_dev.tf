##### Dev Cloudflare API Token for Spacelift
resource "cloudflare_api_token" "dev-spacelift" {
  name = "terraform-cloudflare/dev-spacelift-${local.time}"
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
          id = local.zone_permission_group_ids["Firewall Services Write"]
        },
        {
          id = local.zone_permission_group_ids["Dynamic URL Redirects Write"]
        },
        {
          id = local.zone_permission_group_ids["DNS Write"]
        },
      ]
      resources = jsonencode({
        "com.cloudflare.api.account.zone.${local.zone_ids["cloudjump.dev"]}"              = "*"
        "com.cloudflare.api.account.zone.${local.zone_ids["devopsconsortium.org"]}"       = "*"
        "com.cloudflare.api.account.zone.${local.zone_ids["agent.devopsconsortium.org"]}" = "*"
        "com.cloudflare.api.account.zone.${local.zone_ids["dev.jcplatform.dev"]}"         = "*"
      })
    }
  ]
  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [random_uuid.uuid.result]
  }
}


data "aws_secretsmanager_secret" "cloudflare-dev-api-token" {
  name = "control/cloudflare/dev/api-token"
}

resource "aws_secretsmanager_secret_version" "cloudflare-dev-api-token" {
  secret_id = data.aws_secretsmanager_secret.cloudflare-dev-api-token.id
  secret_string = jsonencode({
    api_token = cloudflare_api_token.dev-spacelift.value
  })
}

resource "spacelift_context" "dev-cloudflare" {
  description = "Dev Cloudflare API Token"
  name        = "dev-cloudflare"
  space_id    = local.edge_spaces["edge-dev"]
  labels      = ["autoattach:dev-cloudflare", "autoattach:dev-cloudfront"]
}

resource "spacelift_environment_variable" "dev-cloudflare_api_token" {
  context_id = spacelift_context.dev-cloudflare.id
  name       = "TF_VAR_cloudflare_api_token"
  value      = cloudflare_api_token.dev-spacelift.value
}

import {
  to = spacelift_context.dev-cloudflare
  id = "dev-cloudflare"
}
