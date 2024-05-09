moved {
  from = module.dns.cloudflare_record.dns_records["kickstart_public-kickstart.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["kickstart_kickstart-public.prd-use1.jcplatform.dev"]
}
