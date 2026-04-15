provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = var.base_prd_aws_region_use1
  assume_role {
    role_arn = "arn:aws:iam::868503801984:role/terraform-admin"
  }
}

provider "aws" {
  alias  = "control-usw2"
  region = "us-west-2"
  assume_role {
    role_arn = "arn:aws:iam::607875384359:role/terraform-admin"
  }
  default_tags {
    tags = {
      Source      = format("TheJumpCloud/terraform-cloudflare/%s", "prd")
      Team        = "edge"
      CostOrg     = "engineering"
      ProductLine = "shared"
      Env         = "control"
    }
  }
}

provider "aws" {
  alias  = "control-euc1"
  region = "eu-central-1"
  assume_role {
    role_arn = "arn:aws:iam::607875384359:role/terraform-admin"
  }
  default_tags {
    tags = {
      Source      = format("TheJumpCloud/terraform-cloudflare/%s", "prd")
      Team        = "edge"
      CostOrg     = "engineering"
      ProductLine = "shared"
      Env         = "control"
    }
  }
}

provider "aws" {
  alias  = "control-aps1"
  region = "ap-south-1"
  assume_role {
    role_arn = "arn:aws:iam::607875384359:role/terraform-admin"
  }
  default_tags {
    tags = {
      Source      = format("TheJumpCloud/terraform-cloudflare/%s", "prd")
      Team        = "edge"
      CostOrg     = "engineering"
      ProductLine = "shared"
      Env         = "control"
    }
  }
}

provider "aws" {
  alias  = "prd02"
  region = "eu-central-1"
  assume_role {
    role_arn = "arn:aws:iam::767397867240:role/terraform-admin"
  }
  default_tags {
    tags = {
      Source      = format("TheJumpCloud/terraform-cloudflare/%s", "prd")
      Team        = "edge"
      CostOrg     = "engineering"
      ProductLine = "shared"
      Env         = "prd02"
    }
  }
}

provider "aws" {
  alias  = "prd02use1"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::767397867240:role/terraform-admin"
  }
  default_tags {
    tags = {
      Source      = format("TheJumpCloud/terraform-cloudflare/%s", "prd")
      Team        = "edge"
      CostOrg     = "engineering"
      ProductLine = "shared"
      Env         = "prd02"
    }
  }
}
