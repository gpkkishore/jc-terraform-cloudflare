terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.13"
    }
  }
  required_version = ">=1.1.9"
}