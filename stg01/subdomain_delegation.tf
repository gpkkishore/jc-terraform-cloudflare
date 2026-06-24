# Note that all of these records are assumed to be a "NS" type, thus there is no option to specify otherwise
#
# id → Route 53 id.stg01.jumpcloud.com (ST-04). Superseded by brand-zone glue when stg01.jumpcloud.com
# is delegated to Route 53 via jumpcloud.com (prd/subdomain_delegation.tf); kept for rollback clarity.
locals {
  stg01_ns_delegation_records = [
    {
      name    = "id"
      ttl     = 300
      content = [
        "ns-608.awsdns-12.net.",
        "ns-197.awsdns-24.com.",
        "ns-1085.awsdns-07.org.",
        "ns-1845.awsdns-38.co.uk.",
      ]
    },
    {
      name    = "ldap"
      ttl     = 300
      content = ["ns-108.awsdns-13.com.", "ns-545.awsdns-04.net.", "ns-1858.awsdns-40.co.uk.", "ns-1250.awsdns-28.org."]
    },
    {
      name    = "ldap-mfa"
      ttl     = 300
      content = ["ns-1521.awsdns-62.org.", "ns-837.awsdns-40.net.", "ns-169.awsdns-21.com.", "ns-1974.awsdns-54.co.uk."]
    }
  ]
}
