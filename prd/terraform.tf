terraform {
  required_version = ">=1.3.2, <2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.29.0"
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
