provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "aws" {
  region = var.base_prd_aws_region_use1
}
