provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# AWS creds in use for arn:aws:iam::800384183171:user/terraform-cloud-tst-cloudflare using admin priveleges
# ^Temporary until the domain transfer work is complete.
# TF Cloud tst-cloudflare workspace is configured for AWS via env variables
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "usw2"
  region = "us-west-2"
}
