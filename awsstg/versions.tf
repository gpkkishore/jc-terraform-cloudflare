terraform {
  required_version = "~> 1.1.9"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.13"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jumpcloud"

    workspaces {
      name = "awsstg-cloudflare"
    }
  }
}

