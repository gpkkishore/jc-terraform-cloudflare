moved {
    from = cloudflare_record.jumpcloud_ai_records["CNAME_jumpcloud.ai._nli-haproxy.ue1-prd-p01.jcplatform.dev"] 
    to   = cloudflare_record.jumpcloud_ai_records["CNAME_jumpcloud.ai._nli.prd-use1.jcplatform.dev"]
}
moved {
    from = module.dns.cloudflare_record.dns_records["*.nli_nli-haproxy.ue1-prd-p01.jcplatform.dev"]
    to   = module.dns.cloudflare_record.dns_records["*.nli_nli.prd-use1.jcplatform.dev"]
}
moved {
    from = module.dns.cloudflare_record.dns_records["nli_nli-haproxy.ue1-prd-p01.jcplatform.dev"]
    to   = module.dns.cloudflare_record.dns_records["nli_nli.prd-use1.jcplatform.dev"]
}
