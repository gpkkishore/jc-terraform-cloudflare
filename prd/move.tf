moved {
  to   = module.dns.cloudflare_record.dns_records["adbridge_adbridge.prd-use1.jcplatform.dev"]
  from = module.dns.cloudflare_record.dns_records["adbridge_prd-adbridge-haproxy-95a0127e2a51ca9c.elb.us-east-1.amazonaws.com"]
}

