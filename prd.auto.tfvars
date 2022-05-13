prd_dns_records = [
  {
    name    = "events-internal-writes"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "dualstack.internal-prd-event-internal-writes-998198845.us-east-1.elb.amazonaws.com"
  },
  {
    name    = "www"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "jumpcloud.com"
  },
  {
    name    = "logging-rmq-admin-panel"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "dualstack.prd-logging-rmq-admin-panel-500485683.us-east-1.elb.amazonaws.com"
  },
  {
    name    = "logging-rmq-use1b"
    proxied = false
    ttl     = 1
    type    = "A"
    value   = "10.31.1.25"
  },
  {
    name    = "mgmt"
    proxied = false
    ttl     = 1
    type    = "A"
    value   = "54.235.213.34"
  },
  {
    name    = "prd-jumpcloud-logging-rmq-use1c-02"
    proxied = false
    ttl     = 60
    type    = "A"
    value   = "10.30.3.24"
  },
  {
    name    = "radius-proxy-1"
    proxied = false
    ttl     = 1
    type    = "A"
    value   = "104.197.52.17"
  },
  {
    name    = "radius-proxy-2"
    proxied = false
    ttl     = 1
    type    = "A"
    value   = "130.211.179.88"
  },
  {
    name    = "radius-proxy-3"
    proxied = false
    ttl     = 1
    type    = "A"
    value   = "130.211.141.152"
  },
  {
    name    = "radius-proxy-4"
    proxied = false
    ttl     = 1
    type    = "A"
    value   = "130.211.178.171"
  },
  {
    name    = "remote"
    proxied = false
    ttl     = 1
    type    = "A"
    value   = "3.90.90.234"
  },
  {
    name    = "adbridge-kickstart"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-adbridge-kickstart-hap-15cdca89ba728b61.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "adbridge"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-adbridge-haproxy-95a0127e2a51ca9c.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "agent"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-agent-haproxy-b20d9869679d351a.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "api"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-api-haproxy-26b2f6dff2b6c74e.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "apple-mdm"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-apple-mdm-haproxy-d05a7a9d47266a34.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "bss"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-si-bss-api-haproxy-6e046266a51cbefa.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "console"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-console-haproxy-7e5666187f103747.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "device-cert"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-device-cert-haproxy-4d41711b05fd478e.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "elastic"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-nlb-kibana-haproxy-e27a67d6237121da.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "kickstart"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-kickstart-public-haproxy-a6276758df0978b6.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "apple.mdm"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-apple-mdm-haproxy-d05a7a9d47266a34.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "private-kickstart"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-kickstart-priv-haproxy-51a0179c97e2d9d8.elb.us-east-1.amazonaws.com"
  },
  {
    name    = "sso"
    proxied = false
    ttl     = 1
    type    = "CNAME"
    value   = "prd-sso-haproxy-f6664e7167075b59.elb.us-east-1.amazonaws.com"
  },
]