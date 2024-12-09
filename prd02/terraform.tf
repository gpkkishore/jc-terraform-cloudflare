terraform {
  required_version = ">=1.3.2, <2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.30"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>4.39"
    }
  }

  backend "s3" {
    bucket         = "jumpcloud-prd02-terraform-state"
    key            = "terraform-cloudflare-prd02/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "jumpcloud-prd02-terraform-state"
    encrypt        = true
  }
}
