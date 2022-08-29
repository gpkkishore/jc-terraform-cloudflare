data "terraform_remote_state" "haproxy_prd" {
  backend = "remote"
  config = {
    organization = "jumpcloud"
    workspaces = {
      name = "prd-haproxy-formula"
    }
  }
}

# See docs/contributing.md for information on how to add a DNS record.
# Note that there are the following arrays, and new records should be placed in the correct array
# prd_a_records     - All the A, AAAA, and ANAME records
# prd_mx_records    - All the MX records. MX records MUST be in this array as they have additional attributes
# prd_cname_records - All the CNAME records
# prd_misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)
locals {
  prd_a_records = [
    // START - Marketing website
    {
      name    = "@",
      proxied = true
      ttl     = 1,
      type    = "A",
      value   = "23.185.0.1",
    },
    {
      name    = "www",
      proxied = true
      ttl     = 1,
      type    = "A",
      value   = "23.185.0.1",
    },
    {
      name    = "www",
      proxied = true
      ttl     = 1,
      type    = "AAAA",
      value   = "2620:12a:8001::1",
    },
    {
      name    = "www",
      proxied = true
      ttl     = 1,
      type    = "AAAA",
      value   = "2620:12a:8000::1",
    },
    {
      name    = "@",
      proxied = true
      ttl     = 1,
      type    = "AAAA",
      value   = "2620:12a:8001::1",
    },
    {
      name    = "@",
      proxied = true
      ttl     = 1,
      type    = "AAAA",
      value   = "2620:12a:8000::1",
    },
    // END - Marketing website
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
      name    = "delfingen-ldap"
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "34.204.118.37"
    },
  ]

  prd_mx_records = [
    {
      name     = "@",
      priority = 1
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "aspmx.l.google.com",
    },
    {
      name     = "@",
      priority = 5
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "alt1.aspmx.l.google.com",
    },
    {
      name     = "@",
      priority = 10
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "alt2.aspmx.l.google.com",
    },
    {
      name     = "@",
      priority = 15
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "aspmx2.googlemail.com",
    },
    {
      name     = "@",
      priority = 20
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "aspmx3.googlemail.com",
    },
    {
      name     = "get",
      priority = 1
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "aspmx.l.google.com",
    },
    {
      name     = "get",
      priority = 5
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "alt1.aspmx.l.google.com",
    },
    {
      name     = "get",
      priority = 5
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "alt2.aspmx.l.google.com",
    },
    {
      name     = "get",
      priority = 10
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "aspmx2.googlemail.com",
    },
    {
      name     = "get",
      priority = 10
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "aspmx3.googlemail.com",
    },
  ]

  prd_cname_records = [
    {
      name    = "events-internal-writes"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "dualstack.internal-prd-event-internal-writes-998198845.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "logging-rmq-admin-panel"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "dualstack.prd-logging-rmq-admin-panel-500485683.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.adbridge_kickstart-haproxy_nlb.lb_dns_name
    },
    {
      name    = "adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.adbridge_nlb.lb_dns_name
    },
    {
      name    = "agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.agent_nlb.lb_dns_name
    },
    {
      name    = "api"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.api_nlb.lb_dns_name
    },
   {
      name    = "assist"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.assist_nlb.lb_dns_name
    },
    {
      name    = "apple-mdm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.apple_mdm_nlb.lb_dns_name
    },
    {
      name    = "bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.si_bss_api_nlb.lb_dns_name
    },
    {
      name    = "console"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.console_nlb.lb_dns_name
    },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.device_cert_nlb.lb_dns_name
    },
    {
      name    = "elastic"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.kibana_nlb.lb_dns_name
    },
    {
      name    = "kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.kickstart_public_nlb.lb_dns_name
    },
    {
      name    = "apple.mdm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.apple_mdm_nlb.lb_dns_name
    },
    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.kickstart_private_nlb.lb_dns_name
    },
    {
      name    = "sso"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.sso_nlb.lb_dns_name
    },
  ]

  prd_misc_records = [
  ]

  prd_dns_records = concat(local.prd_a_records, local.prd_mx_records, local.prd_cname_records, local.prd_misc_records)
}
