locals {
  vpc_tiers = [
    {
      azs = {
        a = {
          enable_natgw = true
          private      = []
          public       = ["10.0.1.0/28"]
        }
      }
      name    = "app"
      network = "10.0.0.0/20"
    }
  ]
}

module "vpcs" {
  source = "git@github.com:JudeQuintana/terraform-modules.git//networking/tiered_vpc_ng?ref=v1.4.2"

  for_each = { for t in local.vpc_tiers : t.name => t }

  env_prefix       = var.env_prefix
  region_az_labels = var.region_az_labels
  tier             = each.value
}
