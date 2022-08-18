terraform {
  required_providers {
      cloudflare = {
          source = "cloudflare/cloudflare"
          version = "~> 3.13"
      }
  }
  required_version = ">=1.1.9"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "jumpcloud"

    workspaces {
      name = "prd-cloudflare"
    }
  }
}
