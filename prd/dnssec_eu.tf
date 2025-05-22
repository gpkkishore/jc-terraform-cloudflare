# Although resources for aws belong in the prd02 aws account, 
# we need to manage the ksk keys and such from the base jumpcloud.com zone

##############################################################
# AWS ldap-mfa.eu.jumpcloud.com and ldap.eu.jumpcloud.com
##############################################################
locals {
  route53_zones_with_dnssec_eu = [
    {
      name = "ldap-mfa.eu.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 300 # 5 Minutes
      }
      soa = {
        # original soa ttl is 900
        ttl = 300 # 5 Minutes
        # original soa record is ["ns-1350.awsdns-40.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        records = ["ns-1350.awsdns-40.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 600"]
      }
    },
    {
      name = "ldap.eu.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 300 # 5 Minutes
      }
      soa = {
        # original soa ttl is 900
        ttl = 300 # 5 Minutes
        # original soa record is ["ns-840.awsdns-41.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        records = ["ns-840.awsdns-41.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 600"]
      }
    },
  ]

  route53_zone_name_to_zone_eu = { for zone in local.route53_zones_with_dnssec_eu : zone.name => zone }
}

data "aws_route53_zone" "zones_with_dnssec_eu" {
  provider = aws.prd02use1
  for_each = local.route53_zone_name_to_zone_eu

  name = each.key
}

# take control of default zone ns and soa records
resource "aws_route53_record" "ns_zones_with_dnssec_eu" {
  provider = aws.prd02use1
  for_each = local.route53_zone_name_to_zone_eu

  name            = each.key
  allow_overwrite = true
  ttl             = each.value.ns.ttl
  type            = "NS"
  zone_id         = lookup(data.aws_route53_zone.zones_with_dnssec_eu, each.key).zone_id
  records         = formatlist("%s.", lookup(data.aws_route53_zone.zones_with_dnssec_eu, each.key).name_servers)
}

resource "aws_route53_record" "soa_zones_with_dnssec_eu" {
  provider = aws.prd02use1
  for_each = local.route53_zone_name_to_zone_eu

  name            = each.key
  allow_overwrite = true
  ttl             = each.value.soa.ttl
  type            = "SOA"
  zone_id         = lookup(data.aws_route53_zone.zones_with_dnssec_eu, each.key).zone_id
  records         = each.value.soa.records
}

##################################################################
# Prepare DNSSEC for Route53 zones
# trailing date (ie 05212025) indicates the date of KSK rotation
# as to not collied with original ksk resources during rotation
# asymmetric elliptic curve KMS keys that are used in DNSSEC Signing
# must be built in us-east-1.
##################################################################
# module "kms_elliptic_curve_for_zones_with_dnssec_eu_05212025" {
#   source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/kms/kms_key?ref=v11.1.2"

#   providers = {
#     aws = aws.prd02use1
#   }
#   for_each = local.route53_zone_name_to_zone_eu

#   name                                     = format("%s-for-dnssec-ksk-%s", replace(each.key, ".", "-"), "05212025") # ldap.prd02.jumpcloud.com -> ldap-prd02-jumpcloud-com-for-dnssec-ksk-05212025
#   customer_master_key_spec                 = "ECC_NIST_P256"
#   key_usage                                = "SIGN_VERIFY"
#   enable_dnssec_policy_with_hosted_zone_id = lookup(data.aws_route53_zone.zones_with_dnssec_eu, each.key).id
#   enable_key_rotation                      = false # Automatic key rotation not supported for asymmetric KMS keys ie ECC
#   deletion_window_in_days                  = 7
#   tags                                     = { Environment = "prd02" }
# }

# resource "aws_route53_key_signing_key" "zones_with_dnssec_05212025" {
#   for_each = local.route53_zone_name_to_zone_eu
#   provider = aws.prd02use1

#   name                       = format("%s-%s", each.key, "05212025")
#   hosted_zone_id             = lookup(data.aws_route53_zone.zones_with_dnssec_eu, each.key).zone_id
#   key_management_service_arn = lookup(module.kms_elliptic_curve_for_zones_with_dnssec_eu_05212025, each.key).arn
#   status                     = "ACTIVE"
# }

# resource "aws_route53_hosted_zone_dnssec" "zones_with_dnssec_eu" {
#   for_each = local.route53_zone_name_to_zone_eu
#   provider = aws.prd02use1

#   hosted_zone_id = lookup(aws_route53_key_signing_key.zones_with_dnssec_05212025, each.key).hosted_zone_id
# }
