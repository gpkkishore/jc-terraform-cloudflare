terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.13"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
  }
  required_version = ">=1.1.9"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jumpcloud"

    workspaces {
      name = "tst-cloudflare"
    }
  }
}
