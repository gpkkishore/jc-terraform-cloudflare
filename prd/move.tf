moved {
  from = module.dns.cloudflare_record.dns_records["kickstart_prd-kickstart-public-haproxy-a6276758df0978b6.elb.us-east-1.amazonaws.com"]
  to   = module.dns.cloudflare_record.dns_records["kickstart_public-kickstart.prd-use1.jcplatform.dev"]
}
