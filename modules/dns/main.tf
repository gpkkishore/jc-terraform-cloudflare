# NS Delegation
### While this expression could be inlined, it was more readable if it was separated - this expression flattens the ns_delegation
### variable so that there is an object for every NS value, since the "cloudflare_record" only supports 1 value for each resource
locals {
  flattened_ns_records = distinct(flatten([
    for entry in var.ns_delegation : [
      for record in entry.value : {
        name = entry.name
        ttl = entry.ttl
        value = record
      }
    ]
  ]))
}

resource "cloudflare_record" "ns_delegation" {
  for_each = { for record in local.flattened_ns_records : record.value => record }
  zone_id  = var.zone_id
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  type     = "NS"
}

# MX Records
resource "cloudflare_record" "mx_records" {
  for_each = { for record in var.mx_records : "${record.name}_${record.value}" => record }
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  priority = each.value.priority
  type     = "MX"
  zone_id  = var.zone_id
}

# DNS Records
resource "cloudflare_record" "dns_records" {
  for_each = { for record in var.dns_records : "${record.name}_${record.value}" => record }
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  type     = each.value.type
  proxied  = each.value.proxied
  zone_id  = var.zone_id
}

# NonPRD Records
# TODO: Move these into their respective working directories, deprecate/remove this module
module "non_prd_dns" {
  count   = var.enable_noncore == true ? 1 : 0
  source  = "./noncore"
  zone_id = var.zone_id
}