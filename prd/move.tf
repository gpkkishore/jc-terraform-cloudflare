moved {
  from = module.dns.cloudflare_record.dns_records["bss_si-bss-api.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["bss_prd-si-bss-api-haproxy-6e046266a51cbefa.elb.us-east-1.amazonaws.com"]
}

