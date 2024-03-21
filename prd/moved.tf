moved {
  from = cloudflare_record.jumpcloud_ai_records["A_jumpcloud.ai._44.216.106.214"]
  to   = cloudflare_record.jumpcloud_ai_records["CNAME_jumpcloud.ai._nli-haproxy.ue1-prd-p01.jcplatform.dev"]
}
