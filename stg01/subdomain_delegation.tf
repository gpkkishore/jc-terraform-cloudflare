# Note that all of these records are assumed to be a "NS" type, thus there is no option to specify otherwise
locals {
  stg01_ns_delegation_records = [
    {
      name  = "id"
      ttl   = 300
      value = ["marvin.ns.cloudflare.com", "wanda.ns.cloudflare.com"]
    },
    {
      name  = "pwm"
      ttl   = 300
      value = ["ns-1609.awsdns-09.co.uk", "ns-392.awsdns-49.com", "ns-1213.awsdns-23.org", "ns-559.awsdns-05.net"]
    }
  ]
}
