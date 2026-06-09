terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.15.0"
    }
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.35"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
  }
  backend "s3" {
    bucket         = "jumpcloud-global-terraform-state"
    key            = "cloudflare-tokens/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "jumpcloud-global-terraform-state"
    encrypt        = true
  }
}
