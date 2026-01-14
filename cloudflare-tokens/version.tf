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
  }
  backend "s3" {
    bucket         = "jumpcloud-global-terraform-state"
    key            = "cloudflare-tokens/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "jumpcloud-global-terraform-state"
    encrypt        = true
  }
}
