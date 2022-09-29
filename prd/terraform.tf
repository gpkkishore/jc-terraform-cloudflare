terraform {
  required_version = ">=1.1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.13"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jumpcloud"

    workspaces {
      name = "prd-cloudflare"
    }
  }
}
