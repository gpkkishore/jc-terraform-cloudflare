###########################################
# DNS Configuration for internal domain.
# TODO: Move this into it's own workspace
###########################################
locals {
  delegation_records = [
    // EKS cluster list from https://github.com/TheJumpCloud/infra-layers
    {
      name  = "uw2-awsstg"
      ttl   = 300
      value = ["ns-1388.awsdns-45.org", "ns-1652.awsdns-14.co.uk", "ns-432.awsdns-54.com", "ns-895.awsdns-47.net"]
    },
    {
      name  = "uw2-staging-00"
      ttl   = 300
      value = ["ns-1039.awsdns-01.org", "ns-141.awsdns-17.com", "ns-1890.awsdns-44.co.uk", "ns-755.awsdns-30.net"]
    },
    {
      name  = "uw2-staging-p01"
      ttl   = 300
      value = ["ns-1062.awsdns-04.org", "ns-108.awsdns-13.com", "ns-1956.awsdns-52.co.uk", "ns-831.awsdns-39.net"]
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
