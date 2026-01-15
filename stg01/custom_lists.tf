# we separate these two lists because of a Cloudflare bug -> https://github.com/cloudflare/terraform-provider-cloudflare/issues/3506
# this issue should have been fixed but we had the same issue with the v4.52.1 provider

locals {
  stg01_wildcard_hostnames = [for hostname in local.stg01_hostnames : hostname if strcontains(hostname, "*")]
  stg01_nonwildcard_hostnames = [for hostname in local.stg01_hostnames : hostname if !strcontains(hostname, "*")]
}

resource "cloudflare_list" "stg01_nonwildcard_hostname_list" {
  account_id  = local.cloudflare_account
  name        = "stg01_nonwildcard_hostnames"
  description = "Non-wildcard hostname list for stg01 domains"
  kind        = "hostname"
}

resource "cloudflare_list" "stg01_wildcard_hostname_list" {
  account_id  = local.cloudflare_account
  name        = "stg01_wildcard_hostnames"
  description = "Wildcard hostname list for stg01 domains"
  kind        = "hostname"
}

resource "cloudflare_list_item" "wildcard_hostname" {
  for_each   = toset(local.stg01_wildcard_hostnames)
  account_id = local.cloudflare_account
  list_id    = cloudflare_list.stg01_wildcard_hostname_list.id

  hostname {
    url_hostname = each.key
  }
}

resource "cloudflare_list_item" "nonwildcard_hostname" {
  for_each   = toset(local.stg01_nonwildcard_hostnames)
  account_id = local.cloudflare_account
  list_id    = cloudflare_list.stg01_nonwildcard_hostname_list.id

  hostname {
    url_hostname = each.key
  }
}

