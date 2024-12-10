terraform {
  required_version = ">=1.3.2, <2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.29.0"
    }
  }

  backend "s3" {
    bucket         = "jumpcloud-stg01-terraform-state"
    key            = "terraform-cloudflare-stg01/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "jumpcloud-stg01-terraform-state"
    encrypt        = true
  }
}
