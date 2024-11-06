# Note that all of these records are assumed to be a "NS" type, thus there is no option to specify otherwise
locals {
  stg01_ns_delegation_records = [
    {
      name  = "id"
      ttl   = 300
      value = ["marvin.ns.cloudflare.com", "wanda.ns.cloudflare.com"]
    },
    {
      name  = "ldap"
      ttl   = 300
      value = ["ns-108.awsdns-13.com.", "ns-545.awsdns-04.net.", "ns-1858.awsdns-40.co.uk.", "ns-1250.awsdns-28.org."]
    },
    {
      name  = "ldap-mfa"
      ttl   = 300
      value = ["ns-1521.awsdns-62.org.", "ns-837.awsdns-40.net.", "ns-169.awsdns-21.com.", "ns-1974.awsdns-54.co.uk."]
    },
    {
      name  = "pwm"
      ttl   = 300
      value = ["ns-1736.awsdns-25.co.uk", "ns-305.awsdns-38.com", "ns-1518.awsdns-61.org", "ns-976.awsdns-58.net"]
    }
  ]
}
