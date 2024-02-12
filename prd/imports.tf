moved {
  from = module.dns.cloudflare_record.dns_records["microsoft-mdm_prd-microsoft-mdm-haproxy-4a840c77868bab58.elb.us-east-1.amazonaws.com"]
  to   = module.dns.cloudflare_record.dns_records["microsoft-mdm_microsoft-mdm.prd-use1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.microsoft-mdm_prd-microsoft-mdm-haproxy-4a840c77868bab58.elb.us-east-1.amazonaws.com"]
  to   = module.dns.cloudflare_record.dns_records["*.microsoft-mdm_microsoft-mdm.prd-use1.jcplatform.dev"]
}
