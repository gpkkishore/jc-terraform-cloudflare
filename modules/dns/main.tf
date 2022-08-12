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
  for_each = { for record in local.flattened_ns_records : record.name => record }
  zone_id  = var.zone_id
  name     = each.name
  value    = each.value
  ttl      = each.ttl
  type     = "NS"
}

# DNS Records
resource "cloudflare_record" "dns_records" {
  for_each = { for record in var.dns_records : record.name => record }
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

# PRD Records
# TODO: These should be cleaned up and moved into their respective working directories, and just passed in as a part of the dns_records var
resource "cloudflare_record" "marketing_website" {
  name    = "@"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "23.185.0.1"
  zone_id = var.zone_id
}

resource "cloudflare_record" "www_marketing_website" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "23.185.0.1"
  zone_id = var.zone_id
}

resource "cloudflare_record" "www_aaaa_marketing_website_1" {
  name    = "www"
  value   = "2620:12a:8001::1"
  type    = "AAAA"
  ttl     = "1"
  proxied = true
  zone_id = var.zone_id
}

resource "cloudflare_record" "www_aaaa_marketing_website_2" {
  name    = "www"
  value   = "2620:12a:8000::1"
  type    = "AAAA"
  ttl     = "1"
  proxied = true
  zone_id = var.zone_id
}

# Original MX records from jumpcloud.com
resource "cloudflare_record" "terraform_managed_resource_b768e60dc1d41bb15d089ccb1db859e0" {
  name     = "@"
  priority = 20
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx3.googlemail.com" #"20 ASPMX3.GOOGLEMAIL.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_c5bce7b1ac03f4eccafa9955e47c0d60" {
  name     = "@"
  priority = 15
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx2.googlemail.com" #"15 ASPMX2.GOOGLEMAIL.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_d7693e2bb7f516ade6bba363b7152e1a" {
  name     = "@"
  priority = 10
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt2.aspmx.l.google.com" #"10 ALT2.ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_cb8166958ff9523ef5ec730250808304" {
  name     = "@"
  priority = 5
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt1.aspmx.l.google.com" #"5 ALT1.ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_b8243683bc1e47302a9ac3693ecfe41a" {
  name     = "@"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx.l.google.com" # "1 ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

#Original MX records from jumpcloud.com
resource "cloudflare_record" "terraform_managed_resource_c8243683bc1e47302a9ac3693ecfe41a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx3.googlemail.com" # "10 ASPMX3.GOOGLEMAIL.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_d8243683bc1e47302a8ac3693ecfe41a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt2.aspmx.l.google.com" #"5 ALT2.ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_18243683bc1e47302a8ac3693ecf453a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx.l.google.com" #"1 ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_23244673bc1e47302a8ac3693ecf453a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx2.googlemail.com" #"10 ASPMX2.GOOGLEMAIL.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_232423433bc1e47302a8ac387ecf453a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt1.aspmx.l.google.com" #"5 ALT1.ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

# Original AAAA records
resource "cloudflare_record" "terraform_managed_resource_9bb19a7d138fd2f365a0035c42f872ce" {
  name    = "@"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8001::1"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_d452c31cc5f76e72f78e4faf2da71199" {
  name    = "@"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8000::1"
  zone_id = var.zone_id
}