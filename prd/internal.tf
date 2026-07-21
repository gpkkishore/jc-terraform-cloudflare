###########################################
# DNS Configuration for internal domain.
# TODO: Move this into its own workspace
###########################################
locals {
  delegation_records = [
    // EKS cluster list from https://github.com/TheJumpCloud/infra-layers
    {
      name  = "prd-use1"
      ttl   = 300
      value = ["ns-900.awsdns-48.net", "ns-1230.awsdns-25.org", "ns-161.awsdns-20.com", "ns-1736.awsdns-25.co.uk"]
    },
    {
      name  = "ue1-prd"
      ttl   = 300
      value = ["ns-1116.awsdns-11.org", "ns-1574.awsdns-04.co.uk", "ns-431.awsdns-53.com", "ns-582.awsdns-08.net"]
    },
    {
      name  = "prd02-euc1"
      ttl   = 300
      value = ["ns-885.awsdns-46.net", "ns-495.awsdns-61.com", "ns-1492.awsdns-58.org", "ns-1811.awsdns-34.co.uk"]
    },
    {
      name  = "prd03-aps1"
      ttl   = 300
      value = ["ns-1761.awsdns-28.co.uk", "ns-567.awsdns-06.net", "ns-1260.awsdns-29.org", "ns-489.awsdns-61.com"]
    },
    {
      name  = "stg01-use2"
      ttl   = 300
      value = ["ns-558.awsdns-05.net", "ns-1818.awsdns-35.co.uk", "ns-1094.awsdns-08.org", "ns-211.awsdns-26.com"]
    },
    {
      name  = "uw2-dev-infr"
      ttl   = 300
      value = ["ns-1512.awsdns-61.org", "ns-1869.awsdns-41.co.uk", "ns-842.awsdns-41.net", "ns-68.awsdns-08.com"]
    }, # Managed in jumpcloud/test-infra repo
    {
      name  = "uw2-tst-infr"
      ttl   = 300
      value = ["ns-984.awsdns-59.net", "ns-1906.awsdns-46.co.uk", "ns-1433.awsdns-51.org", "ns-42.awsdns-05.com"]
    }, # Managed in jumpcloud/test-infra repo
    {
      name  = "design-internal"
      ttl   = 300
      value = ["ns-1264.awsdns-30.org", "ns-661.awsdns-18.net", "ns-1790.awsdns-31.co.uk", "ns-420.awsdns-52.com"]
    },
    {
      name = "dev"
      ttl  = 300
      # delegate to cloudflare
      value = ["marvin.ns.cloudflare.com", "wanda.ns.cloudflare.com"]
    },
    {
      name  = "trust"
      ttl   = 300
      value = ["ns-1069.awsdns-05.org", "ns-692.awsdns-22.net", "ns-1915.awsdns-47.co.uk", "ns-199.awsdns-24.com"]
    }
  ]

  internal_only_records = [
    {
      name  = "eda-dbt-documentation"
      ttl   = 300
      type  = "CNAME"
      value = "d2k34i1ti5bssq.cloudfront.net"
    },
    # ACM DNS validation CNAMEs formerly in marketing-internal.jcplatform.dev
    # (orphaned when NS delegation collapsed into jcplatform.dev).
    {
      name  = "_c77f0fe692de5e10692c8cf01d088d74.marketing-internal"
      ttl   = 300
      type  = "CNAME"
      value = "_ea6a4b2477d3bc329802eb1981967846.mhbtsbpdnt.acm-validations.aws"
    },
    {
      name  = "_9306b0fc62e6f64e737011d2615c5a73.www.marketing-internal"
      ttl   = 300
      type  = "CNAME"
      value = "_ff11cec1ef59555cc189d7c12ea1a8ad.mhbtsbpdnt.acm-validations.aws"
    },
  ]

  # Alias A records in jcplatform.dev (Route 53 rejects CNAME-to-ELB at apex-style names).
  internal_alias_records = [
    {
      name                   = "marketing-internal"
      alias_name             = "d3d61011c209cf0c2b83e5959e49829c-330411615.us-east-1.elb.amazonaws.com"
      alias_zone_id          = "Z35SXDOTRQ7X7K"
      evaluate_target_health = false
    }
  ]
}

resource "aws_route53_zone" "jc_internal_zone" {
  name = "jcplatform.dev"
}

resource "aws_route53_record" "jc_internal_zone" {
  for_each = { for delegation in local.delegation_records : delegation.name => delegation }
  zone_id  = aws_route53_zone.jc_internal_zone.zone_id
  name     = "${each.value.name}.${aws_route53_zone.jc_internal_zone.name}"
  type     = "NS"
  ttl      = each.value.ttl
  records  = each.value.value
}

resource "aws_route53_record" "jc_insternal_only_records" {
  for_each = { for internal_only_record in local.internal_only_records : internal_only_record.name => internal_only_record }
  zone_id  = aws_route53_zone.jc_internal_zone.zone_id
  name     = each.value.name
  type     = each.value.type
  ttl      = each.value.ttl
  records  = [each.value.value]
}

resource "aws_route53_record" "jc_internal_alias_records" {
  for_each = { for record in local.internal_alias_records : record.name => record }
  zone_id  = aws_route53_zone.jc_internal_zone.zone_id
  name     = each.value.name
  type     = "A"

  alias {
    name                   = each.value.alias_name
    zone_id                = each.value.alias_zone_id
    evaluate_target_health = each.value.evaluate_target_health
  }
}
