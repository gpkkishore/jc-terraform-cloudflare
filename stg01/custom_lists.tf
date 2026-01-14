resource "cloudflare_list" "stg01_hostname_list" {
  account_id  = local.cloudflare_account
  name        = "stg01_hostnames"
  description = "Hostname list for stg01 domains (required for wildcard support)"
  kind        = "hostname"
}

resource "cloudflare_list_item" "hostname" {
  for_each   = toset(local.stg01_hostnames)
  account_id = local.cloudflare_account
  list_id    = cloudflare_list.stg01_hostname_list.id

  hostname {
    url_hostname = each.key
  }
}

