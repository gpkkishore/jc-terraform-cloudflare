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
  ]

  stg_mx_records = [
  ]

  stg_cname_records = [
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
      value   = data.terraform_remote_state.haproxy_stg.outputs.api_nlb.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "bss"
      value   = data.terraform_remote_state.haproxy_stg.outputs.bss_nlb.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "apple.mdm"
      value   = data.terraform_remote_state.haproxy_stg.outputs.apple_mdm_nlb.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "adbridge-kickstart"
      value   = data.terraform_remote_state.haproxy_stg.outputs.adbridge_kickstart_nlb.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "adbridge"
      value   = data.terraform_remote_state.haproxy_stg.outputs.adbridge_nlb.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "agent"
      value   = data.terraform_remote_state.haproxy_stg.outputs.agent_nlb.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "console"
      value   = data.terraform_remote_state.haproxy_stg.outputs.console_nlb.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "device-cert"
      value   = data.terraform_remote_state.haproxy_stg.outputs.device_cert_nlb.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "elastic"
      value   = data.terraform_remote_state.haproxy_stg.outputs.elastic_nlb.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "kickstart"
      value   = data.terraform_remote_state.haproxy_stg.outputs.agent_kickstart_public.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "private-kickstart"
      value   = data.terraform_remote_state.haproxy_stg.outputs.agent_private_kickstart.lb_dns_name
      type    = "CNAME"
      ttl     = 1
      proxied = false
    },
    {
      name    = "sso"
      value   = data.terraform_remote_state.haproxy_stg.outputs.sso_nlb.lb_dns_name
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

  stg_misc_records = [
  ]

  // TODO: Special treatment to add awsstg prefix
  stg_dns_records = concat(local.stg_a_records, local.stg_cname_records, local.stg_misc_records)
}
