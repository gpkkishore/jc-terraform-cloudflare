# Note that all of these records are assumed to be a "NS" type, thus there is no option to specify otherwise
locals {
  prd_ns_delegation_records = [
    {
      name    = "ldap"
      ttl     = 300
      value   = ["ns-1519.awsdns-61.org.", "ns-1718.awsdns-22.co.uk.", "ns-393.awsdns-49.com.", "ns-869.awsdns-44.net."]
    },
    {
      name    = "ldap-mfa"
      ttl     = 300
      value   = ["ns-1341.awsdns-39.org.","ns-246.awsdns-30.com.","ns-973.awsdns-57.net.","ns-2007.awsdns-58.co.uk."]
    },
    {
      name    = "radius"
      ttl     = 300
      value   = ["ns-1931.awsdns-49.co.uk.", "ns-1434.awsdns-51.org.", "ns-465.awsdns-58.com.", "ns-585.awsdns-09.net."]
    },
    {
      name    = "awsstg"
      ttl     = 300
      value   = ["blakely.ns.cloudflare.com.", "keenan.ns.cloudflare.com."]
    },
    {
      name    = "sec"
      ttl     = 300
      value   = ["ns-1471.awsdns-55.org.","ns-1632.awsdns-12.co.uk.","ns-493.awsdns-61.com.","ns-731.awsdns-27.net."]
    },
  ]
}
