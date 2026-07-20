# Note that all of these records are assumed to be a "NS" type, thus there is no option to specify otherwise
locals {
  prd_ns_delegation_records = [
    {
      name  = "vault"
      ttl   = 300
      value = ["marvin.ns.cloudflare.com.", "wanda.ns.cloudflare.com."]
    },
    # vault.eu / ldap*.eu / radius.eu NS live under R53 eu.jumpcloud.com after
    # the eu zone cutover — do not republish them on the CF jumpcloud.com parent.
    {
      name  = "id"
      ttl   = 300
      value = ["marvin.ns.cloudflare.com.", "wanda.ns.cloudflare.com."]
    },
    {
      name  = "ldap"
      ttl   = 300
      value = ["ns-1519.awsdns-61.org.", "ns-1718.awsdns-22.co.uk.", "ns-393.awsdns-49.com.", "ns-869.awsdns-44.net."]
    },
    {
      name  = "ldap-mfa"
      ttl   = 300
      value = ["ns-1341.awsdns-39.org.", "ns-246.awsdns-30.com.", "ns-973.awsdns-57.net.", "ns-2007.awsdns-58.co.uk."]
    },
    {
      name  = "radius"
      ttl   = 300
      value = ["ns-1931.awsdns-49.co.uk.", "ns-1434.awsdns-51.org.", "ns-465.awsdns-58.com.", "ns-585.awsdns-09.net."]
    },
    {
      name  = "sec"
      ttl   = 300
      value = ["ns-1471.awsdns-55.org.", "ns-1632.awsdns-12.co.uk.", "ns-493.awsdns-61.com.", "ns-731.awsdns-27.net."]
    },
    {
      name  = "securitydesk"
      ttl   = 300
      value = ["ns-693.awsdns-22.net.", "ns-1642.awsdns-13.co.uk.", "ns-1050.awsdns-03.org.", "ns-454.awsdns-56.com."]
    },
    {
      name  = "stg01"
      ttl   = 300
      value = [
        "ns-480.awsdns-60.com.",
        "ns-1647.awsdns-13.co.uk.",
        "ns-1281.awsdns-32.org.",
        "ns-949.awsdns-54.net.",
      ]
    },
    {
      name  = "prd02"
      ttl   = 300
      value = ["marvin.ns.cloudflare.com.", "wanda.ns.cloudflare.com."]
    },
    {
      name  = "in"
      ttl   = 300
      value = ["ns-2009.awsdns-59.co.uk.", "ns-72.awsdns-09.com.", "ns-871.awsdns-44.net.", "ns-1111.awsdns-10.org."]
    },
    {
      name  = "eu"
      ttl   = 300
      value = ["ns-1285.awsdns-32.org.", "ns-245.awsdns-30.com.", "ns-1894.awsdns-44.co.uk.", "ns-917.awsdns-50.net."]
    },
    {
      name  = "dev-p03"
      ttl   = 300
      value = ["ns-1690.awsdns-19.co.uk.", "ns-1163.awsdns-17.org.", "ns-665.awsdns-19.net.", "ns-417.awsdns-52.com."]
    },
  ]
}
