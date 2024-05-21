moved {
  from = module.dns.cloudflare_record.dns_records["device-cert_prd-device-cert-haproxy-4d41711b05fd478e.elb.us-east-1.amazonaws.com"]
  to   = module.dns.cloudflare_record.dns_records["device-cert_device-cert.prd-use1.jcplatform.dev"]
}

