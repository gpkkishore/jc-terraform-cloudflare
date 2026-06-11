# Delegate jcops child router zones from parent jcops.net.
# Child zones must exist (stg01 #840, eu/in #849) before prd-cloudflare apply.

data "cloudflare_zone" "stg01_jcops_net" {
  account_id = local.account_id
  name       = "stg01.jcops.net"
}

data "cloudflare_zone" "eu_jcops_net" {
  account_id = local.account_id
  name       = "eu.jcops.net"
}

data "cloudflare_zone" "in_jcops_net" {
  account_id = local.account_id
  name       = "in.jcops.net"
}

locals {
  jcops_child_ns_delegation_records = [
    {
      name  = "stg01"
      ttl   = 300
      value = formatlist("%s.", data.cloudflare_zone.stg01_jcops_net.name_servers)
    },
    {
      name  = "eu"
      ttl   = 300
      value = formatlist("%s.", data.cloudflare_zone.eu_jcops_net.name_servers)
    },
    {
      name  = "in"
      ttl   = 300
      value = formatlist("%s.", data.cloudflare_zone.in_jcops_net.name_servers)
    },
  ]
}
