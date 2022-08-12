# Note that all of these records are assumed to be a "NS" type, thus there is no option to specify otherwise
locals {
  tst_ns_delegation_records = [
    {
      name    = "ldap"
      ttl     = 300
      # Note that these records differ from prod - they point to ldap.cloudjump.dev
      value   = ["ns-1430.awsdns-50.org.", "ns-642.awsdns-16.net.", "ns-425.awsdns-53.com.", "ns-1944.awsdns-51.co.uk."]
    },
    {
      name    = "ldap-mfa"
      ttl     = 300
      value   = ["ns-1341.awsdns-39.org.","ns-246.awsdns-30.com.","ns-973.awsdns-57.net.","ns-2007.awsdns-58.co.uk."]
    },
    {
      name    = "radius"
      ttl     = 300
      # Note that these records differ from prod - they point to radius.cloudjump.dev
      value   = ["ns-1851.awsdns-39.co.uk.", "ns-719.awsdns-25.net.", "ns-433.awsdns-54.com.", "ns-1252.awsdns-28.org."]
    },
    {
      name    = "awsstg"
      ttl     = 300
      value   = ["ns-241.awsdns-30.com.", "ns-811.awsdns-37.net.", "ns-1689.awsdns-19.co.uk.", "ns-1192.awsdns-21.org."]
    },
    {
      name    = "sec"
      ttl     = 300
      value   = ["ns-1471.awsdns-55.org.","ns-1632.awsdns-12.co.uk.","ns-493.awsdns-61.com.","ns-731.awsdns-27.net."]
    },
  ]
}