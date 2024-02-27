moved {
  from = module.dns.cloudflare_record.dns_records["apple-mdm_prd-apple-mdm-haproxy-d05a7a9d47266a34.elb.us-east-1.amazonaws.com"]
  to   = module.dns.cloudflare_record.dns_records["apple-mdm_apple-mdm.prd-use1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["apple.mdm_prd-apple-mdm-haproxy-d05a7a9d47266a34.elb.us-east-1.amazonaws.com"]
  to   = module.dns.cloudflare_record.dns_records["apple.mdm_apple-mdm.prd-use1.jcplatform.dev"]
}
