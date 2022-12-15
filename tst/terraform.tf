terraform {
  required_version = ">=1.3.2, <2.0.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>3.13"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.40"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jumpcloud"

    workspaces {
      name = "tst-cloudflare"
    }
  }
}
