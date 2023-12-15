###########################################
# DNS Configuration for internal domain.
# TODO: Move this into its own workspace
###########################################
locals {
  delegation_records = [
    // EKS cluster list from https://github.com/TheJumpCloud/infra-layers
    {
      name  = "stg01-use2-p00"
      ttl   = 300
      value = ["ns-1371.awsdns-43.org", "ns-773.awsdns-32.net", "ns-424.awsdns-53.com", "ns-2015.awsdns-59.co.uk"]
    },
    {
      name  = "stg01-use2-p01"
      ttl   = 300
      value = ["ns-1529.awsdns-63.org", "ns-829.awsdns-39.net", "ns-98.awsdns-12.com", "ns-1903.awsdns-45.co.uk"]
    },
    {
      name  = "stg01-use2-p01-c01"
      ttl   = 300
      value = ["ns-1072.awsdns-06.org", "ns-1541.awsdns-00.co.uk", "ns-112.awsdns-14.com", "ns-912.awsdns-50.net"]
    },
    {
      name  = "ue1-prd"
      ttl   = 300
      value = ["ns-1116.awsdns-11.org", "ns-1574.awsdns-04.co.uk", "ns-431.awsdns-53.com", "ns-582.awsdns-08.net"]
    },
    {
      name  = "uw2-dev-p01"
      ttl   = 300
      value = ["ns-1676.awsdns-17.co.uk", "ns-194.awsdns-24.com", "ns-1195.awsdns-21.org", "ns-842.awsdns-41.net"]
    },
    {
      name  = "uw2-dev-c01"
      ttl   = 300
      value = ["ns-121.awsdns-15.com", "ns-1387.awsdns-45.org", "ns-1800.awsdns-33.co.uk", "ns-845.awsdns-41.net"]
    },
    {
      name  = "ue1-prd-p01"
      ttl   = 300
      value = ["ns-872.awsdns-45.net", "ns-1048.awsdns-03.org", "ns-1687.awsdns-18.co.uk", "ns-322.awsdns-40.com"]
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
      name  = "sec-use1-p00"
      ttl   = 300
      value = ["ns-1641.awsdns-13.co.uk", "ns-154.awsdns-19.com", "ns-756.awsdns-30.net", "ns-1286.awsdns-32.org"]
    },
    {
      name  = "stg01-use2"
      ttl   = 300
      value = ["ns-558.awsdns-05.net", "ns-1818.awsdns-35.co.uk", "ns-1094.awsdns-08.org", "ns-211.awsdns-26.com"]
    },
    {
      name  = "control"
      ttl   = 300
      value = ["ns-385.awsdns-48.com", "ns-837.awsdns-40.net", "ns-1554.awsdns-02.co.uk", "ns-1395.awsdns-46.org"]
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
