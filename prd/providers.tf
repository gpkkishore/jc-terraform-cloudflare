provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = var.base_prd_aws_region_use1
  assume_role {
    role_arn = "arn:aws:iam::868503801984:role/terraform-admin"
  } 
}
