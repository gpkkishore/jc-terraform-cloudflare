terraform {
  required_version = ">=1.3.2, <2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.48.0"
    }
  }

  backend "s3" {
    bucket         = "jumpcloud-global-terraform-state"
    key            = "terraform-cloudflare-global/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "jumpcloud-global-terraform-state"
    encrypt        = true
  }
}
