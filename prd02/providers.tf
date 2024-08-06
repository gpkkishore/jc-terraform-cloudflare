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
