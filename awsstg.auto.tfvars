awsstg_dns_records = [
  {
    name    = "awsstg-events-elasticsearch-usw2b-01"
    value   = "10.20.1.127"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  {
    name    = "awsstg-events-elasticsearch-usw2b-02"
    value   = "10.20.1.179"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  {
    name    = "awsstg-events-elasticsearch-usw2b-03"
    value   = "10.20.1.104"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  {
    name    = "awsstg-mongo-datadb-usw2b-primary"
    value   = "10.20.1.239"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  {
    name    = "awsstg-mongo-datadb-usw2b-secondary-01"
    value   = "10.20.1.72"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  {
    name    = "awsstg-mongo-datadb-usw2b-secondary-02"
    value   = "10.20.1.254"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  {
    name    = "events"
    value   = "10.20.1.55"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  {
    name    = "us1.radius"
    value   = "52.89.214.200"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  {
    name    = "us2.radius"
    value   = "13.57.87.164"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  {
    name    = "radius"
    value   = "52.89.214.200"
    type    = "A"
    ttl     = 1
    proxied = false
  },
  # ldap = "10.20.1.193"
  # ldap = "10.20.33.198",  # Is this supposed replicate regional deployment?
  # radius = "13.57.87.164"
  # {
  #   name    = "sso"
  #   value   = "awsstg-sso-haproxy-1c5c07d1c09a69bd.elb.us-west-2.amazonaws.com"
  #   type    = "CNAME"
  #   ttl     = 1
  #   proxied = false
  # },
  {
    name    = "assets"
    value   = "d193ib4v2852zx.cloudfront.net"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "_35077d2d975b04cc14a4666712e06846.assets"
    value   = "_1733e553fa78674dac3d1c6b3b7fc826.nhqijqilxf.acm-validations.aws"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "_e76c0c4507ca0ec38fed8a613af07534.demo"
    value   = "_a180c18c380e2b126b7428529cb9631a.olprtlswtu.acm-validations.aws"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "sentry"
    value   = "dualstack.internal-awsstg-sentry-1598789881.us-west-2.elb.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "api"
    value   = "awsstg-api-haproxy-da4156afde33c7f1.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "bss"
    value   = "awsstg-si-bss-api-haproxy-af17284e86128e27.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "apple.mdm"
    value   = "awsstg-apple-mdm-haproxy-ada1cbff4b84e7d2.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "adbridge-kickstart"
    value   = "awsstg-adbridge-kickstart-hap-80b532e17309fb71.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "adbridge"
    value   = "awsstg-adbridge-haproxy-cd77d9c0d55c25b3.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "agent"
    value   = "awsstg-agent-haproxy-862d6f7afe6d676e.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  # {
  #   name    = "console"
  #   value   = "awsstg-console-haproxy-431fa260ac3793b1.elb.us-west-2.amazonaws.com"
  #   type    = "CNAME"
  #   ttl     = 1
  #   proxied = false
  # },
  {
    name    = "device-cert"
    value   = "awsstg-device-cert-haproxy-97826775d48c4ee3.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "elastic"
    value   = "awsstg-nlb-kibana-haproxy-eb196ccbe7191ba0.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "kickstart"
    value   = "awsstg-kickstart-public-haproxy-edeb465a29d6d267.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "ldap"
    value   = "awsstg-openldap-haproxy-19317b047f6e5d7c.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "private-kickstart"
    value   = "awsstg-kickstart-priv-haproxy-5622d27a151a0496.elb.us-west-2.amazonaws.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "web-a"
    value   = "web.awsstg.jumpcloud.com"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  },
  {
    name    = "web"
    value   = "j.sni.global.fastly.net"
    type    = "CNAME"
    ttl     = 1
    proxied = false
  }

]
