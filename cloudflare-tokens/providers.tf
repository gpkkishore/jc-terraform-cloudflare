locals {
  dev_account   = "800384183171"
  stg01_account = "330105897241"
  prd_account   = "868503801984"
  prd02_account = "767397867240"
  ctrl_account  = "607875384359"
  default_tags = {
    Team        = "Edge"
    Source      = "TheJumpCloud/terraform-cloudflare/cloudflare-tokens"
    CostOrg     = "engineering"
    ProductLine = "internal"
  }
}


provider "spacelift" {}

provider "aws" {
  region = "us-east-2"
  assume_role {
    role_arn = format("arn:aws:iam::%s:role/terraform-admin", local.ctrl_account)
  }
  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  alias  = "dev"
  region = "us-west-2"
  assume_role {
    role_arn = format("arn:aws:iam::%s:role/terraform-admin", local.dev_account)
  }
  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  alias  = "stg01"
  region = "us-east-2"
  assume_role {
    role_arn = format("arn:aws:iam::%s:role/terraform-admin", local.stg01_account)
  }
  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  alias  = "prd"
  region = "us-east-1"
  assume_role {
    role_arn = format("arn:aws:iam::%s:role/terraform-admin", local.prd_account)
  }
  default_tags {
    tags = local.default_tags
  }
}

provider "aws" {
  alias  = "prd02"
  region = "eu-central-1"
  assume_role {
    role_arn = format("arn:aws:iam::%s:role/terraform-admin", local.prd02_account)
  }
  default_tags {
    tags = local.default_tags
  }
}
