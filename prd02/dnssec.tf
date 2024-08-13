locals {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = "3c96d914c0eaa62b7b4c9960e63818f7"
}

# Cloudflare zones with DNSSEC
locals {
  cloudflare_root_zone         = "jumpcloud.com"
  cloudflare_child_zones       = ["prd02.jumpcloud.com"]
  cloudflare_zones_with_dnssec = toset(concat([local.cloudflare_root_zone], local.cloudflare_child_zones))
}

# prepare cloudflare zone prd02.jumpcloud.com for dnssec by generating values for the DS record.
# only need to create cloudflare_child_zones_with_dnssec because jumpcloud.com zone already has dnsse enabled in the prd env so we just need to read it with data source.
data "cloudflare_zone" "zones_with_dnssec" {
  for_each = local.cloudflare_zones_with_dnssec

  account_id = local.account_id
  name       = each.key
}

resource "cloudflare_zone_dnssec" "child_zones_with_dnssec" {
  for_each = toset(local.cloudflare_child_zones)

  zone_id = lookup(data.cloudflare_zone.zones_with_dnssec, each.key).id
}

# enable DNSSEC for child cloudflare zones
resource "cloudflare_record" "ds_cloudflare_zones_with_dnssec" {
  for_each = toset(local.cloudflare_child_zones)

  zone_id = lookup(data.cloudflare_zone.zones_with_dnssec, local.cloudflare_root_zone).id
  name    = each.key
  type    = "DS"
  proxied = false
  data {
    algorithm   = lookup(data.cloudflare_zone_dnssec.zones_with_dnssec, each.key).algorithm
    digest      = lookup(data.cloudflare_zone_dnssec.zones_with_dnssec, each.key).digest
    digest_type = lookup(data.cloudflare_zone_dnssec.zones_with_dnssec, each.key).digest_type
    key_tag     = lookup(data.cloudflare_zone_dnssec.zones_with_dnssec, each.key).key_tag
  }
}

# Route53 zones with DNSSEC
#locals {
#route53_zones_with_dnssec = [
#{
#name = "ldap.prd02.jumpcloud.com"
#ns = {
## original ns ttl is 172800
#ttl = 86400 # 1-day
#}
#soa = {
## original soa ttl is 900
#ttl = 900
## original soa record is ["ns-869.awsdns-44.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
## ^updating last entry to 3600 for each zone from AWS UI or dig command
#records = ["ns-869.awsdns-44.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
#}
#},
#{
#name = "ldap-mfa.prd02.jumpcloud.com"
#ns = {
## original ns ttl is 172800
#ttl = 86400 # 1-day
#}
#soa = {
## original soa ttl is 900
#ttl     = 900
#records = ["ns-1147.awsdns-15.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
#}
#}
# {
#   name = "pwm.jumpcloud.com"
#   ns = {
#     # original ns ttl is 172800
#     ttl = 86400 # 1-day
#   }
#   soa = {
#     # original soa ttl is 900
#     ttl = 900
#     # original soa record is ["ns-1575.awsdns-04.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
#     # ^updating last entry to 3600 for each zone from AWS UI or dig command
#     records = ["ns-1575.awsdns-04.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
#   }
# },
# {
#   name = "radius.jumpcloud.com"
#   ns = {
#     # original ns ttl is 172800
#     ttl = 86400 # 1-day
#   }
#   soa = {
#     # original soa ttl is 900
#     ttl = 900
#     # original soa record is ["ns-1931.awsdns-49.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
#     # ^updating last entry to 3600 for each zone from AWS UI or dig command
#     records = ["ns-1931.awsdns-49.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
#   }
# },
#]

#route53_zone_name_to_zone = { for zone in local.route53_zones_with_dnssec : zone.name => zone }
#}


#data "aws_route53_zone" "zones_with_dnssec" {
#for_each = local.route53_zone_name_to_zone

#name = each.key
#}

## take control of default zone ns and soa records
#resource "aws_route53_record" "ns_zones_with_dnssec" {
#for_each = local.route53_zone_name_to_zone

#name            = each.key
#allow_overwrite = true
#ttl             = each.value.ns.ttl
#type            = "NS"
#zone_id         = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).zone_id
#records         = formatlist("%s.", lookup(data.aws_route53_zone.zones_with_dnssec, each.key).name_servers)
#}

#resource "aws_route53_record" "soa_zones_with_dnssec" {
#for_each = local.route53_zone_name_to_zone

#name            = each.key
#allow_overwrite = true
#ttl             = each.value.soa.ttl
#type            = "SOA"
#zone_id         = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).zone_id
#records         = each.value.soa.records
#}
