terraform {
  required_version = ">=1.3.2, <2.0.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.29.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.40"
    }
  }

  backend "s3" {
    bucket = "jumpcloud-dev-terraform-state"
    key    = "terraform-cloudflare-dev/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "jumpcloud-dev-terraform-state"
    encrypt = true
  }
}
