locals {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = "3c96d914c0eaa62b7b4c9960e63818f7"
}

# Cloudflare zones with DNSSEC
locals {
  cloudflare_root_zone        = "jumpcloud.com"
  cloudflare_prd03_child_zone = "in.jumpcloud.com"
  cloudflare_child_zones      = [local.cloudflare_prd03_child_zone]
}

# Look up the root zone only (it already exists in Cloudflare).
# The child zone in.jumpcloud.com is created by cloudflare_zone.cloudflare_zone_resource in main.tf,
# so we reference that resource directly.
data "cloudflare_zone" "root_zone" {
  account_id = local.account_id
  name       = local.cloudflare_root_zone
}

resource "cloudflare_zone_dnssec" "child_zones_with_dnssec" {
  for_each = toset(local.cloudflare_child_zones)

  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

# enable DNSSEC for child cloudflare zones — DS record goes in the root zone
resource "cloudflare_record" "ds_cloudflare_zones_with_dnssec" {
  for_each = toset(local.cloudflare_child_zones)

  zone_id = data.cloudflare_zone.root_zone.id
  name    = each.key
  type    = "DS"
  proxied = false
  data {
    algorithm   = lookup(cloudflare_zone_dnssec.child_zones_with_dnssec, each.key).algorithm
    digest      = lookup(cloudflare_zone_dnssec.child_zones_with_dnssec, each.key).digest
    digest_type = lookup(cloudflare_zone_dnssec.child_zones_with_dnssec, each.key).digest_type
    key_tag     = lookup(cloudflare_zone_dnssec.child_zones_with_dnssec, each.key).key_tag
  }
}

##################################################################
# Route53 zones with DNSSEC
#
# TODO: The Route53 hosted zones for ldap.prd03.jumpcloud.com and
# ldap-mfa.prd03.jumpcloud.com do not exist yet. They will be created
# by the infra-layers edge deployment. Once they exist, uncomment
# the sections below and update the SOA records with actual values
# from the Route53 zones.
##################################################################

locals {
  route53_zones_with_dnssec = [
    {
      name = "ldap.in.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 86400 # 1-day
      }
      soa = {
        # original soa ttl is 900
        # original soa record is ns-1217.awsdns-24.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
        ttl = 900
        records = ["ns-1217.awsdns-24.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
      }
    },
    {
      name = "ldap-mfa.in.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 86400 # 1-day
      }
      soa = {
        # original soa ttl is 900
        # original soa record is ns-896.awsdns-48.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
        ttl     = 900
        records = ["ns-896.awsdns-48.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
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
  records         = formatlist("%s.", lookup(data.aws_route53_zone.zones_with_dnssec, each.key).name_servers) # add trailing dot to name servers
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

##################################################################
# Prepare DNSSEC for Route53 zones
# trailing date (ie 09042026) indicates the date of KSK rotation
# as to not collide with original ksk resources during rotation
# asymmetric elliptic curve KMS keys that are used in DNSSEC Signing
# must be built in us-east-1.
##################################################################

module "kms_elliptic_curve_for_zones_with_dnssec_09042026" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/kms/kms_key?ref=v11.1.2"

  providers = {
    aws = aws.use1
  }

  for_each = local.route53_zone_name_to_zone

  name                                     = format("%s-for-dnssec-ksk-%s", replace(each.key, ".", "-"), "09042026")
  customer_master_key_spec                 = "ECC_NIST_P256"
  key_usage                                = "SIGN_VERIFY"
  enable_dnssec_policy_with_hosted_zone_id = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).id
  enable_key_rotation                      = false # Automatic key rotation not supported for asymmetric KMS keys ie ECC
  deletion_window_in_days                  = 7
  tags                                     = { Environment = var.env }
}

resource "aws_route53_key_signing_key" "zones_with_dnssec_09042026" {
  for_each = local.route53_zone_name_to_zone

  name                       = format("%s-%s", each.key, "09042026")
  hosted_zone_id             = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).zone_id
  key_management_service_arn = lookup(module.kms_elliptic_curve_for_zones_with_dnssec_09042026, each.key).arn
  status                     = "ACTIVE"
}

# create DS record in the child zone relative to each route53 zone which verifies the related KSKs hosted zone's DNSKEY
resource "cloudflare_record" "ds_route53_zones_with_dnssec_09042026" {
  for_each = local.route53_zone_name_to_zone

  zone_id = cloudflare_zone.cloudflare_zone_resource.id
  name    = each.key
  type    = "DS"
  proxied = false
  data {
    algorithm   = lookup(aws_route53_key_signing_key.zones_with_dnssec_09042026, each.key).signing_algorithm_type
    digest      = lookup(aws_route53_key_signing_key.zones_with_dnssec_09042026, each.key).digest_value
    digest_type = lookup(aws_route53_key_signing_key.zones_with_dnssec_09042026, each.key).digest_algorithm_type
    key_tag     = lookup(aws_route53_key_signing_key.zones_with_dnssec_09042026, each.key).key_tag
  }

  depends_on = [aws_route53_hosted_zone_dnssec.zones_with_dnssec]
}

resource "aws_route53_hosted_zone_dnssec" "zones_with_dnssec" {
  for_each = local.route53_zone_name_to_zone

  hosted_zone_id = lookup(aws_route53_key_signing_key.zones_with_dnssec_09042026, each.key).hosted_zone_id
}
