# Cloudflare zones with DNSSEC
locals {
  cloudflare_root_zone         = "jumpcloud.com" # needs to separate for reference of the root zone later
  cloudflare_child_zones       = ["id.jumpcloud.com", "awsstg.jumpcloud.com"]
  cloudflare_zones_with_dnssec = toset(concat([local.cloudflare_root_zone], local.cloudflare_child_zones))
}

# prepare cloudflare zone jumpcloud.com for dnssec by generating values for the DS record.
data "cloudflare_zone" "zones_with_dnssec" {
  for_each = local.cloudflare_zones_with_dnssec

  account_id = local.account_id
  name       = each.key
}

resource "cloudflare_zone_dnssec" "zones_with_dnssec" {
  for_each = local.cloudflare_zones_with_dnssec

  zone_id = lookup(data.cloudflare_zone.zones_with_dnssec, each.key).id
}

# enable DNSSEC for child cloudflare zones
resource "cloudflare_record" "ds_cloudflare_zones_with_dnssec" {
  for_each = toset(local.cloudflare_child_zones)

  zone_id = lookup(data.cloudflare_zone.zones_with_dnssec, local.cloudflare_root_zone).id
  name    = trimsuffix(each.key, format(".%s", local.cloudflare_root_zone)) # id.jumpcloud.com -> id
  type    = "DS"
  proxied = false
  data {
    algorithm   = 13
    digest      = lookup(cloudflare_zone_dnssec.zones_with_dnssec, each.key).digest
    digest_type = 2
    key_tag     = lookup(cloudflare_zone_dnssec.zones_with_dnssec, each.key).key_tag
  }
}

# Route53 zones with DNSSEC
locals {
  route53_zones_with_dnssec = [
    {
      name = "ldap.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 86400 # 1-day
      }
      soa = {
        # original soa ttl is 900
        ttl = 900
        # original soa record is ["ns-869.awsdns-44.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        # ^updating last entry to 3600 for each zone from AWS UI or dig command
        records = ["ns-869.awsdns-44.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
      }
    },
    {
      name = "ldap-mfa.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 86400 # 1-day
      }
      soa = {
        # original soa ttl is 900
        ttl = 900
        # original soa record is ["ns-1341.awsdns-39.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        # ^updating last entry to 3600 for each zone from AWS UI or dig command
        records = ["ns-1341.awsdns-39.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
      }
    },
    {
      name = "pwm.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 86400 # 1-day
      }
      soa = {
        # original soa ttl is 900
        ttl = 900
        # original soa record is ["ns-1575.awsdns-04.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        # ^updating last entry to 3600 for each zone from AWS UI or dig command
        records = ["ns-1575.awsdns-04.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
      }
    },
    {
      name = "radius.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 86400 # 1-day
      }
      soa = {
        # original soa ttl is 900
        ttl = 900
        # original soa record is ["ns-1931.awsdns-49.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        # ^updating last entry to 3600 for each zone from AWS UI or dig command
        records = ["ns-1931.awsdns-49.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
      }
    },
  ]

  route53_zone_name_to_zone = { for zone in local.route53_zones_with_dnssec : zone.name => zone }
}

data "aws_route53_zone" "zones_with_dnssec" {
  for_each = local.route53_zone_name_to_zone

  name = each.key
}

# take control of default zone ns and soa records
resource "aws_route53_record" "ns_zones_with_dnssec" {
  for_each = local.route53_zone_name_to_zone

  name            = each.key
  allow_overwrite = true
  ttl             = each.value.ns.ttl
  type            = "NS"
  zone_id         = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).zone_id
  records         = formatlist("%s.", lookup(data.aws_route53_zone.zones_with_dnssec, each.key).name_servers)
}

resource "aws_route53_record" "soa_zones_with_dnssec" {
  for_each = local.route53_zone_name_to_zone

  name            = each.key
  allow_overwrite = true
  ttl             = each.value.soa.ttl
  type            = "SOA"
  zone_id         = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).zone_id
  records         = each.value.soa.records
}

####################################
# Prepare DNSSEC for Route53 zones #
####################################
module "kms_elliptic_curve_for_zones_with_dnssec" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/kms/kms_key?ref=v6.11.4"

  for_each = local.route53_zone_name_to_zone

  name                     = format("%s-for-ksk", replace(each.key, ".", "-")) # ldap.jumpcloud.com -> ldap-jumpcloud-com-for-ksk
  customer_master_key_spec = "ECC_NIST_P256"
  key_usage                = "SIGN_VERIFY"
  enable_dnssec_policy     = true
  enable_key_rotation      = false # Automatic key rotation not supported for asymmetric KMS keys ie ECC
  deletion_window_in_days  = 7
  tags                     = { Environment = var.env_prefix }
}

resource "aws_route53_key_signing_key" "zones_with_dnssec" {
  for_each = local.route53_zone_name_to_zone

  name                       = each.key
  hosted_zone_id             = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).zone_id
  key_management_service_arn = lookup(module.kms_elliptic_curve_for_zones_with_dnssec, each.key).arn
  status                     = contains(["radius.jumpcloud.com", "pwm.jumpcloud.com"], each.key) ? "INACTIVE" : "ACTIVE"
}

resource "aws_route53_hosted_zone_dnssec" "zones_with_dnssec" {
  for_each = local.route53_zone_name_to_zone

  hosted_zone_id = lookup(aws_route53_key_signing_key.zones_with_dnssec, each.key).hosted_zone_id
}

##################################################################
# Prepare DNSSEC for Route53 zones
# trailing date (ie 05222023) indicates the date of KSK rotation
# as to not collied with original ksk resources during rotation
##################################################################
module "kms_elliptic_curve_for_zones_with_dnssec_05222023" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/kms/kms_key?ref=v6.11.4"

  for_each = local.route53_zone_name_to_zone

  name                     = format("%s-for-dnssec-ksk", replace(each.key, ".", "-")) # ldap.jumpcloud.com -> ldap-jumpcloud-com-for-dnssec-ksk
  customer_master_key_spec = "ECC_NIST_P256"
  key_usage                = "SIGN_VERIFY"
  enable_dnssec_policy     = true
  enable_key_rotation      = false # Automatic key rotation not supported for asymmetric KMS keys ie ECC
  deletion_window_in_days  = 7
  tags                     = { Environment = var.env_prefix }
}

resource "aws_route53_key_signing_key" "zones_with_dnssec_05222023" {
  for_each = local.route53_zone_name_to_zone

  name                       = format("%s-%s", each.key, "05222023")
  hosted_zone_id             = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).zone_id
  key_management_service_arn = lookup(module.kms_elliptic_curve_for_zones_with_dnssec_05222023, each.key).arn
}

# create DS record in jumpcloud.com parent zone relative to each route53 zone
resource "cloudflare_record" "ds_route53_zones_with_dnssec_05222023" {
  for_each = local.route53_zone_name_to_zone

  zone_id = lookup(data.cloudflare_zone.zones_with_dnssec, local.cloudflare_root_zone).id
  name    = each.key
  type    = "DS"
  proxied = false
  data {
    algorithm   = lookup(aws_route53_key_signing_key.zones_with_dnssec_05222023, each.key).signing_algorithm_type
    digest      = lookup(aws_route53_key_signing_key.zones_with_dnssec_05222023, each.key).digest_value
    digest_type = lookup(aws_route53_key_signing_key.zones_with_dnssec_05222023, each.key).digest_algorithm_type
    key_tag     = lookup(aws_route53_key_signing_key.zones_with_dnssec_05222023, each.key).key_tag
  }

  depends_on = [aws_route53_hosted_zone_dnssec.zones_with_dnssec]
}

####################################
# Enable DNSSEC for Route53 zones  #
####################################
locals {
  # keeping separate from local.route53_zone_name_to_zone because DS data comes after aws_route53_hosted_zone_dnssec.zones_with_dnssec is applied
  # but ds record data can't be pulled from the resource directly, only from the AWS UI or CLI
  ds_data_for_route53_zones_with_dnssec = [
    {
      name    = "ldap.jumpcloud.com"
      digest  = "02CA74E878171FE5B8F31684AFB3EF45F21B45C0CD6C60B4792089AF30042B11"
      key_tag = 19179
    },
    #{
    #name    = "ldap-mfa.jumpcloud.com"
    #digest  = "D383E946AE9035819A01EA7B3946245F99007F2D279AB880A982311DEA24F96F"
    #key_tag = 55836
    #},
    #{
    #name    = "pwm.jumpcloud.com"
    #digest  = "9558ACC700F448D384ACD71BF86AE8C9973721FE0791CFF41E572863D61074CB"
    #key_tag = 48601
    #},
    #{
    #name    = "radius.jumpcloud.com"
    #digest  = "1E7FDAA1FCF3D72D28890F6BE36EE3FEB985EE6EFCA9467E6D69FE1188575306"
    #key_tag = 31316
    #}
  ]

  route53_zone_name_to_zone_ds_data = { for zone_ds_data in local.ds_data_for_route53_zones_with_dnssec : zone_ds_data.name => zone_ds_data }
}

# enable DNSSEC by creating the DS record in jumpcloud.com parent zone relative to each route53 zone
resource "cloudflare_record" "ds_route53_zones_with_dnssec" {
  for_each = local.route53_zone_name_to_zone_ds_data

  zone_id = lookup(data.cloudflare_zone.zones_with_dnssec, local.cloudflare_root_zone).id
  name    = trimsuffix(each.key, format(".%s", local.cloudflare_root_zone)) # ldap.jumpcloud.com -> ldap
  type    = "DS"
  proxied = false
  data {
    algorithm   = 13
    digest      = each.value.digest
    digest_type = 2
    key_tag     = each.value.key_tag
  }

  depends_on = [aws_route53_hosted_zone_dnssec.zones_with_dnssec]
}

