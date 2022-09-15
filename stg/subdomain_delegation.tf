# Note that all of these records are assumed to be a "NS" type, thus there is no option to specify otherwise
locals {
  stg_ns_delegation_records = [
    {
      name  = "identity"
      ttl   = 300
      value = ["ns-1940.awsdns-50.co.uk.", "ns-183.awsdns-22.com.", "ns-918.awsdns-50.net.", "ns-1392.awsdns-46.org."]
    },
    {
      name  = "id"
      ttl   = 300
      value = ["ns-1865.awsdns-41.co.uk.", "ns-1046.awsdns-02.org.", "ns-651.awsdns-17.net.", "ns-213.awsdns-26.com."]
    },
    {
      name  = "ldap"
      ttl   = 300
      value = ["ns-1998.awsdns-57.co.uk.", "ns-535.awsdns-02.net.", "ns-21.awsdns-02.com.", "ns-1487.awsdns-57.org."]
    },
    {
      name  = "ldap-mfa"
      ttl   = 300
      value = ["ns-128.awsdns-16.com.", "ns-1292.awsdns-33.org.", "ns-953.awsdns-55.net.", "ns-1820.awsdns-35.co.uk."]
    },
    {
      name  = "pwm"
      ttl   = 300
      value = ["ns-1864.awsdns-41.co.uk.", "ns-753.awsdns-30.net.", "ns-1351.awsdns-40.org.", "ns-313.awsdns-39.com."]
    },
  ]
}
