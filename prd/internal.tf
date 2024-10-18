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
      name  = "ue1-prd-p01"
      ttl   = 300
      value = ["ns-872.awsdns-45.net", "ns-1048.awsdns-03.org", "ns-1687.awsdns-18.co.uk", "ns-322.awsdns-40.com"]
    },
    {
      name  = "prd02-euc1"
      ttl   = 300
      value = ["ns-885.awsdns-46.net", "ns-495.awsdns-61.com", "ns-1492.awsdns-58.org", "ns-1811.awsdns-34.co.uk"]
    },
    {
      name  = "prd02-euc1-p00"
      ttl   = 300
      value = ["ns-118.awsdns-14.com", "ns-1476.awsdns-56.org", "ns-1962.awsdns-53.co.uk", "ns-921.awsdns-51.net"]
    },
    {
      name  = "stg01-use2"
      ttl   = 300
      value = ["ns-558.awsdns-05.net", "ns-1818.awsdns-35.co.uk", "ns-1094.awsdns-08.org", "ns-211.awsdns-26.com"]
    },
    {
      name  = "stg01-use2-p00"
      ttl   = 300
      value = ["ns-1160.awsdns-17.org", "ns-822.awsdns-38.net", "ns-36.awsdns-04.com", "ns-1973.awsdns-54.co.uk"]
    },
    {
      name  = "stg01-use2-p01"
      ttl   = 300
      value = ["ns-1529.awsdns-63.org", "ns-829.awsdns-39.net", "ns-98.awsdns-12.com", "ns-1903.awsdns-45.co.uk"]
    },
    {
      name  = "stg01-apne1-p00"
      ttl   = 300
      value = ["ns-1216.awsdns-24.org", "ns-677.awsdns-20.net", "ns-92.awsdns-11.com", "ns-1940.awsdns-50.co.uk"]
    },
    {
      name  = "uw2-dev-p01"
      ttl   = 300
      value = ["ns-1676.awsdns-17.co.uk", "ns-194.awsdns-24.com", "ns-1195.awsdns-21.org", "ns-842.awsdns-41.net"]
    },
    {
      name  = "dev-usw2-p02"
      ttl   = 300
      value = ["ns-1918.awsdns-47.co.uk", "ns-299.awsdns-37.com", "ns-1532.awsdns-63.org", "ns-640.awsdns-16.net"]
    },
    {
      name  = "dev-usw2-p03"
      ttl   = 300
      value = ["ns-2046.awsdns-63.co.uk", "ns-370.awsdns-46.com", "ns-1096.awsdns-09.org", "ns-625.awsdns-14.net"]
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
      name  = "control"
      ttl   = 300
      value = ["ns-385.awsdns-48.com", "ns-837.awsdns-40.net", "ns-1554.awsdns-02.co.uk", "ns-1395.awsdns-46.org"]
    },
    {
      name  = "marketing-internal"
      ttl   = 300
      value = ["ns-1122.awsdns-12.org", "ns-888.awsdns-47.net", "ns-1722.awsdns-23.co.uk", "ns-267.awsdns-33.com"]
    },
    {
      name  = "cicd-usw2-acceptance"
      ttl   = 300
      value = ["ns-18.awsdns-02.com", "ns-1378.awsdns-44.org", "ns-668.awsdns-19.net", "ns-2019.awsdns-60.co.uk"]
    },
    {
      name  = "design-internal"
      ttl   = 300
      value = ["ns-1264.awsdns-30.org", "ns-661.awsdns-18.net", "ns-1790.awsdns-31.co.uk", "ns-420.awsdns-52.com"]
    },
    {
      name  = "dev"
      ttl   = 300
      # delegate to cloudflare
      value = ["marvin.ns.cloudflare.com", "wanda.ns.cloudflare.com"]
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
