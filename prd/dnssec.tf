# prepare cloudflare zone jumpcloud.com for dnssec by generating values for the DS record.
resource "cloudflare_zone_dnssec" "jumpcloud_com" {
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

locals {
  route53_zones_with_dnssec = [
    {
      name = "ldap.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 300
      }
      soa = {
        # original soa ttl is 900
        ttl = 300
        # original soa record is ["ns-869.awsdns-44.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        # ^updting last entry to 600 for each zone from AWS UI or dig command
        records = ["ns-869.awsdns-44.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 600"]
      }
    },
    {
      name = "ldap-mfa.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 300
      }
      soa = {
        # original soa ttl is 900
        ttl = 300
        # original soa record is ["ns-1341.awsdns-39.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        # ^updting last entry to 600 for each zone from AWS UI or dig command
        records = ["ns-1341.awsdns-39.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 600"]
      }
    },
    {
      name = "pwm.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 300
      }
      soa = {
        # original soa ttl is 900
        ttl = 300
        # original soa record is ["ns-1575.awsdns-04.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        # ^updting last entry to 600 for each zone from AWS UI or dig command
        records = ["ns-1575.awsdns-04.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 600"]
      }
    },
    {
      name = "radius.jumpcloud.com"
      ns = {
        # original ns ttl is 172800
        ttl = 300
      }
      soa = {
        # original soa ttl is 900
        ttl = 300
        # original soa record is ["ns-1931.awsdns-49.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
        # ^updting last entry to 600 for each zone from AWS UI or dig command
        records = ["ns-1931.awsdns-49.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 600"]
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
locals {
  # temporarily only allow DNSSEC prep for ldap.jumpcloud.com and ldap-mfa.jumpcloud.com
  only_ldap_zones                 = ["ldap.jumpcloud.com", "ldap-mfa.jumpcloud.com"]
  gated_route53_zone_name_to_zone = { for zone_name, zone in local.route53_zone_name_to_zone : zone_name => zone if contains(local.only_ldap_zones, zone_name) }
}

module "kms_elliptic_curve_for_zones_with_dnssec" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/kms/kms_key?ref=v6.6.3"

  for_each = local.gated_route53_zone_name_to_zone

  name                     = format("%s-for-ksk", replace(each.key, ".", "-")) # ldap.jumpcloud.com -> ldap-jumpcloud-com-for-ksk
  customer_master_key_spec = "ECC_NIST_P256"
  key_usage                = "SIGN_VERIFY"
  enable_dnssec_policy     = true
  enable_key_rotation      = false # Automatic key rotation not supported for asymmetric KMS keys ie ECC
  deletion_window_in_days  = 7
  tags                     = { Environment = var.env_prefix }
}

resource "aws_route53_key_signing_key" "zones_with_dnssec" {
  for_each = local.gated_route53_zone_name_to_zone

  name                       = each.key
  hosted_zone_id             = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).zone_id
  key_management_service_arn = lookup(module.kms_elliptic_curve_for_zones_with_dnssec, each.key).arn
}

resource "aws_route53_hosted_zone_dnssec" "zones_with_dnssec" {
  for_each = local.gated_route53_zone_name_to_zone

  hosted_zone_id = lookup(aws_route53_key_signing_key.zones_with_dnssec, each.key).hosted_zone_id
}

############################################################################################################################################################
# monitor for DNSSEC errors because DataDog can't pull the DNSSEC metrics from the AWS cloudwatch integration
# all topic subscrptions must be manually confirmed before notifcations are sent from cloudwatch
# sometime google will filter the emails for an email distrobution list but not sure why ie edge-team@jumpcloud.com
# if an individual email (name.last@jumpcloud.com) will likely show up in spam folder.
# doens't have to be an email subscription but wasnt able to pull metrics for DNSSEC in Datadog.
############################################################################################################################################################
module "dnssec_error_alerts_sns_topic" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/sns?ref=v6.6.5"

  env_prefix         = var.env_prefix
  region_short_names = var.region_az_labels
  topic_name         = "dnssec-errors"
  tags               = { Environment = var.env_prefix }
  subscriptions = [
    {
      protocol = "email"
      endpoint = "jude.quintana@jumpcloud.com"
    }
  ]
}

resource "aws_cloudwatch_metric_alarm" "dnssec_ksk_alarm_for_zones_with_dnssec" {
  for_each = local.gated_route53_zone_name_to_zone

  alarm_name          = format("%s-dnssec-ksk", replace(each.key, ".", "-")) # ldap.jumpcloud.com -> ldap-jumpcloud-com-dnssec-ksk
  comparison_operator = "GreaterThanThreshold"
  metric_name         = "DNSSECKeySigningKeysNeedingAction"
  namespace           = "AWS/Route53"
  period              = 1500
  datapoints_to_alarm = 1
  evaluation_periods  = 1
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "DNSSEC monitoring for DNSSECKeySigningKeysNeedingAction metric"
  alarm_actions       = [module.dnssec_error_alerts_sns_topic.arn]
  dimensions = {
    HostedZoneId = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).id
  }

  depends_on = [aws_route53_hosted_zone_dnssec.zones_with_dnssec]
}

resource "aws_cloudwatch_metric_alarm" "dnssec_internal_failure_for_alarm_zones_with_dnssec" {
  for_each = local.gated_route53_zone_name_to_zone

  alarm_name          = format("%s-dnssec-internal-failure", replace(each.key, ".", "-")) # ldap.jumpcloud.com -> ldap-jumpcloud-com-dnssec-internal-failure
  comparison_operator = "GreaterThanThreshold"
  metric_name         = "DNSSECInternalFailure"
  namespace           = "AWS/Route53"
  period              = 1500
  datapoints_to_alarm = 1
  evaluation_periods  = 1
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "DNSSEC monitoring for DNSSECInternalFailure metric"
  alarm_actions       = [module.dnssec_error_alerts_sns_topic.arn]
  dimensions = {
    HostedZoneId = lookup(data.aws_route53_zone.zones_with_dnssec, each.key).id
  }

  depends_on = [aws_route53_hosted_zone_dnssec.zones_with_dnssec]
}

####################################
# Enable DNSSEC for Route53 zones  #
####################################
locals {
  # keeping separate from local.route53_zone_name_to_zone because DS data comes after aws_route53_hosted_zone_dnssec.zones_with_dnssec is applied
  # but ds record data can't be pulled from the resource, only from the AWS UI
  ds_data_for_route53_zones_with_dnssec = [
    {
      name    = "ldap.jumpcloud.com"
      digest  = "02CA74E878171FE5B8F31684AFB3EF45F21B45C0CD6C60B4792089AF30042B11"
      key_tag = 19179
    },
    {
      name    = "ldap-mfa.jumpcloud.com"
      digest  = "D383E946AE9035819A01EA7B3946245F99007F2D279AB880A982311DEA24F96F"
      key_tag = 55836
    }
  ]

  gated_route53_zone_name_to_ds_data = { for zone in local.ds_data_for_route53_zones_with_dnssec : zone.name => zone if contains(local.only_ldap_zones, zone.name) }
}

# enable DNSSEC by creating the DS record in jumpcloud.com parent zone relative to each route53 zone
resource "cloudflare_record" "ds_route53_zones_with_dnssec" {
  for_each = local.gated_route53_zone_name_to_ds_data

  zone_id = cloudflare_zone.cloudflare_zone_resource.id
  name    = trimsuffix(each.key, format(".%s", cloudflare_zone.cloudflare_zone_resource.zone)) # ldap.jumpcloud.com -> ldap
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

