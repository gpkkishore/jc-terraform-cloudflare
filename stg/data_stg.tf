data "terraform_remote_state" "haproxy_stg" {
  backend = "remote"
  config = {
    organization = "jumpcloud"
    workspaces = {
      name = "awsstg-haproxy-formula"
    }
  }
}

# See docs/contributing.md for information on how to add a DNS record.
# Note that there are the following arrays, and new records should be placed in the correct array
# stg_a_records     - All the A, AAAA, and ANAME records
# stg_mx_records    - All the MX records. MX records MUST be in this array as they have additional attributes
# stg_cname_records - All the CNAME records
# stg_misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)
locals {
  stg_a_records = [
    {
      name    = "awsstg-events-elasticsearch-usw2b-01"
      proxied = false
      ttl     = 300
      type    = "A"
      value   = "10.20.1.127"
    },
    {
      name    = "awsstg-events-elasticsearch-usw2b-02"
      proxied = false
      ttl     = 300
      type    = "A"
      value   = "10.20.1.179"
    },
    {
      name    = "awsstg-events-elasticsearch-usw2b-03"
      proxied = false
      ttl     = 300
      type    = "A"
      value   = "10.20.1.104"
    },
    {
      name    = "awsstg-mongo-datadb-usw2b-primary"
      proxied = false
      ttl     = 30
      type    = "A"
      value   = "10.20.1.239"
    },
    {
      name    = "awsstg-mongo-datadb-usw2b-secondary-01"
      proxied = false
      ttl     = 30
      type    = "A"
      value   = "10.20.1.72"
    },
    {
      name    = "awsstg-mongo-datadb-usw2b-secondary-02"
      proxied = false
      ttl     = 30
      type    = "A"
      value   = "10.20.1.254"
    },
    {
      name    = "events"
      proxied = false
      ttl     = 300
      type    = "A"
      value   = "10.20.1.55"
    },
    {
      name    = "radius"
      proxied = false
      ttl     = 300
      type    = "A"
      value   = "13.57.87.164"
    },
    {
      name    = "radius"
      proxied = false
      ttl     = 300
      type    = "A"
      value   = "52.89.214.200"
    },
    {
      name    = "us1.radius"
      proxied = false
      ttl     = 300
      type    = "A"
      value   = "52.89.214.200"
    },
    {
      name    = "us2.radius"
      proxied = false
      ttl     = 300
      type    = "A"
      value   = "13.57.87.164"
    }
  ]

  stg_mx_records = [
  ]

  stg_cname_records = [
    {
      name    = "adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.adbridge_kickstart_nlb.lb_dns_name
    },
    {
      name    = "adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.adbridge_nlb.lb_dns_name
    },
    {
      name    = "agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.agent_nlb.lb_dns_name
    },
    {
      name    = "api"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.api_nlb.lb_dns_name
    },
    {
      name    = "assist"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "awsstg-assist-haproxy-e45ad0d88c274312.elb.us-west-2.amazonaws.com"
    },
    {
      name    = "bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.bss_nlb.lb_dns_name
    },
    {
      name    = "console"
      proxied = false
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.console_nlb.lb_dns_name
    },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.device_cert_nlb.lb_dns_name
    },
    {
      name    = "elastic"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.elastic_nlb.lb_dns_name
    },
    {
      name    = "kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.agent_kickstart_public.lb_dns_name
    },
    {
      name    = "apple.mdm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.apple_mdm_nlb.lb_dns_name
    },
    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.agent_private_kickstart.lb_dns_name
    },
    {
      name    = "sentry"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "dualstack.internal-awsstg-sentry-1598789881.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "sso"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_stg.outputs.sso_nlb.lb_dns_name
    },
    {
      name    = "delegated-auth.us-west-2"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "internal-awsstg-us-west-2-auth-lambda-791991147.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "assets"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "d193ib4v2852zx.cloudfront.net"
    },
    {
      name    = "_35077d2d975b04cc14a4666712e06846.assets"
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "_1733e553fa78674dac3d1c6b3b7fc826.nhqijqilxf.acm-validations.aws"
    },
    {
      name    = "cdn"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "d2008dpdnzrhly.cloudfront.net"
    },
    {
      name    = "_df0cfd5c0b60d4f1f50c62b29f705964.cdn"
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "_709803936126501b060c1cc0900bd01e.nhsllhhtvj.acm-validations.aws"
    },
    {
      name    = "_e76c0c4507ca0ec38fed8a613af07534.demo"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "_a180c18c380e2b126b7428529cb9631a.olprtlswtu.acm-validations.aws"
    },
    {
      name    = "_0921a601a8d7472ed2fc08c2ec3c0229.delegated-auth.us-west-2"
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "_442fe84fd4a8e2bb5c930e4cc9a1b039.vrztfgqhxj.acm-validations.aws"
    },
    {
      name    = "web-a"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "web.awsstg.jumpcloud.com"
    },
    {
      name    = "web"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "j.sni.global.fastly.net"
    }
  ]

  stg_misc_records = [
    {
      name    = "@"
      proxied = false
      ttl     = "300"
      type    = "TXT"
      value   = "google-site-verification=fUOm_FpYJ2K5rcOwrAUxvJRIjl5klKUl11FdvUx-yRw"
    }
  ]

  stg_dns_records = concat(local.stg_a_records, local.stg_cname_records, local.stg_mx_records, local.stg_misc_records)
}
