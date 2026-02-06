data "terraform_remote_state" "spacelift_admin" {
  backend = "s3"
  config = {
    bucket = "jumpcloud-global-terraform-state"
    key    = "spacelift-admin/terraform.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "edge_stacks" {
  backend = "s3"
  config = {
    bucket = "jumpcloud-global-terraform-state"
    key    = "edge-stacks/terraform.tfstate"
    region = "us-east-2"
  }
}


data "cloudflare_api_token_permission_groups_list" "acct" {
  scope = "com.cloudflare.api.account"
}

data "cloudflare_api_token_permission_groups_list" "zone" {
  scope = "com.cloudflare.api.account.zone"
}

data "cloudflare_api_token_permission_groups_list" "user" {
  scope = "com.cloudflare.api.user"
}

data "cloudflare_zones" "all" {
  account = {
    id = local.cloudflare_account_id
  }
  direction = "desc"
}

locals {
  cloudflare_account_id     = "3c96d914c0eaa62b7b4c9960e63818f7" # JumpCloud Enterprise
  zone_ids                  = { for k in data.cloudflare_zones.all.result : k.name => k.id }
  acct_permission_group_ids = { for k in data.cloudflare_api_token_permission_groups_list.acct.result : k.name => k.id }
  zone_permission_group_ids = { for k in data.cloudflare_api_token_permission_groups_list.zone.result : k.name => k.id }
  user_permission_group_ids = { for k in data.cloudflare_api_token_permission_groups_list.user.result : k.name => k.id }
  time                      = formatdate("YYYY-MM-DD-hh:mm:ssZZZ", timestamp())
  edge_spaces               = data.terraform_remote_state.edge_stacks.outputs.edge_spaces
  env_spaces                = data.terraform_remote_state.spacelift_admin.outputs.env_spaces
}


resource "random_uuid" "uuid" {
  keepers = {
    current_time = timestamp()
  }
}

#All cloudflare API token resources MUST be depended on by the time_sleep resource to allow propagation of new tokens before destruction of old tokens
resource "time_sleep" "wait" {
  depends_on = [
    cloudflare_api_token.dev-spacelift,
    cloudflare_api_token.stg01-spacelift,
    cloudflare_api_token.stg01-cloudfront,
    cloudflare_api_token.stg01-use2-edge-tenancy,
    cloudflare_api_token.prd-spacelift,
    cloudflare_api_token.prd-cloudfront,
    cloudflare_api_token.prd-website,
    cloudflare_api_token.prd02-spacelift,
    cloudflare_api_token.prd02-euc1-edge-tenancy,
    cloudflare_api_token.prd03-spacelift,
    cloudflare_api_token.prd03-aps1-edge-tenancy,
    cloudflare_api_token.global-spacelift
  ]

  destroy_duration = "30m"

  lifecycle {
    create_before_destroy = true
    replace_triggered_by  = [random_uuid.uuid.result]
  }
}
