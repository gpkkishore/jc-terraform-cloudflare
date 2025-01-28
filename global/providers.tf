provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = "eu-central-1"

  assume_role {
    role_arn = format("arn:aws:iam::%s:role/terraform-admin", local.aws_account)
  }

  default_tags {
    tags = {
      Source      = format("TheJumpCloud/terraform-cloudflare/%s", local.env)
      Team        = "edge"
      CostOrg     = "engineering"
      ProductLine = "shared"
      Env         = local.env
    }
  }
}
