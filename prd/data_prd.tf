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
  # This is a list of new zones to create in CF - this is only required for zones that should be managed by TF that don't have their
  # own workspace in this repo (i.e, not jumpcloud.com, stg01.jumpcloud.com, and cloudjump.dev)
  # NOTE: Every zone in this array gets assigned an enterprise license, don't use it for testing!
  cloudflare_zones = [
    "id.jumpcloud.com",
    "id.stg01.jumpcloud.com",
    "jumpcloudlounge.com",
    "zercurity.com",
  ]

  # The name used in the custom_certs object is only used for internal metadata
  custom_certs = [
    {
      name              = "apple-mdm"
      hosts             = ["apple.mdm.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "microsoft-mdm"
      hosts             = ["*.microsoft-mdm.jumpcloud.com", "microsoft-mdm.jumpcloud.com"]
      validation_method = "txt"
    }
  ]

  prd_a_records = [
    // START - Marketing website
    {
      name    = "@",
      proxied = true
      ttl     = 1,
      type    = "CNAME",
      value   = "d3d61011c209cf0c2b83e5959e49829c-330411615.us-east-1.elb.amazonaws.com",
    },
    {
      name    = "www",
      proxied = true
      ttl     = 1,
      type    = "CNAME",
      value   = "d3d61011c209cf0c2b83e5959e49829c-330411615.us-east-1.elb.amazonaws.com",
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
    {
      name    = "devopsdays",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "192.155.251.138"
    },
    {
      name    = "kanban",
      proxied = false
      ttl     = 300
      type    = "A"
      value   = "10.240.0.53"
    },
    {
      name    = "nat1b",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "54.86.131.111"
    },
    {
      name    = "nat1c",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "54.86.134.208"
    },
    {
      name    = "nat1d",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "54.86.96.53"
    },
    {
      name    = "o1.em",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "198.21.2.137"
    },
    {
      name    = "o2.ptr1370.test",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "168.245.76.83"
    },
    {
      name    = "staging-radius-proxy",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "130.211.178.124"
    },
    {
      name    = "staging-vpn",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "104.196.2.104"
    },
    {
      name    = "test-vpn",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "52.40.206.145"
    },
    {
      name    = "test",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "54.235.82.193"
    },
    {
      name    = "vpn",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "34.207.90.19"
    },
    {
      name    = "www-old-maintain-sl-presence",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "50.23.90.245"
    },
    // These dev/staging records are for pre-prod envs on the marketing website (hosted through lightsail)
    {
      name    = "staging",
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "100.21.168.142"
    },
    {
      name    = "dev",
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "100.20.80.37"
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
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.api_nlb.lb_dns_name
    },
    {
      name    = "assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.assist_nlb.lb_dns_name
    },
    {
      name    = "apple-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.prd-use1.jcplatform.dev"
    },
    {
      name    = "microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.microsoft-mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "microsoft-mdm.prd-use1.jcplatform.dev"
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
      proxied = true
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
      name    = "kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.kickstart_public_nlb.lb_dns_name
    },
    {
      name    = "apple.mdm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.prd-use1.jcplatform.dev"
    },

    {
      name    = "go"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.go_nlb.lb_dns_name
    },

    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.kickstart_private_nlb.lb_dns_name
    },
    {
      name    = "jumpdesk"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpdesk.prd-use1.jcplatform.dev"
    },
    {
      name    = "login"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.login_api_nlb.lb_dns_name
      value   = "login-api.prd-use1.jcplatform.dev"
    },
    {
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.oauth_nlb.lb_dns_name
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = data.terraform_remote_state.haproxy_prd.outputs.sso_nlb.lb_dns_name
    },
    {
      name    = "devvpn",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "mgmt.jumpcloud.com"
    },
    {
      name    = "do-1241-test",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "s3-website.us-east-2.amazonaws.com"
    },
    {
      name    = "staging-agent",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "staging.jumpcloud.com"
    },
    {
      name    = "staging-kickstart",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "staging.jumpcloud.com"
    },
    {
      name    = "sysvpn",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "mgmt.jumpcloud.com"
    },
    {
      name    = "test-agent",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "test.jumpcloud.com"
    },
    {
      name    = "test-console",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "test.jumpcloud.com"
    },
    {
      name    = "test-kickstart",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "test.jumpcloud.com"
    },
    {
      name    = "817177",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "sendgrid.net"
    },
    {
      name    = "_acme-challenge",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "o1tlam9icixerjtpgp.fastly-validations.com"
    },
    {
      name    = "4nplil46eu5vyxptxoqivkbrl4jgmbfq._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "4nplil46eu5vyxptxoqivkbrl4jgmbfq.dkim.amazonses.com"
    },
    {
      name    = "hmjo4qtf7j7w4mclfnvk7ohprauna75y._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "hmjo4qtf7j7w4mclfnvk7ohprauna75y.dkim.amazonses.com"
    },
    {
      name    = "nwt._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "nwt.domainkey.u2555077.wl078.sendgrid.net"
    },
    {
      name    = "nwt2._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "nwt2.domainkey.u2555077.wl078.sendgrid.net"
    },
    {
      name    = "s1._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "s1.domainkey.u817177.wl.sendgrid.net"
    },
    {
      name    = "s2._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "s2.domainkey.u817177.wl.sendgrid.net"
    },
    {
      name    = "spg._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "spg.domainkey.u12100069.wl070.sendgrid.net"
    },
    {
      name    = "spg2._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "spg2.domainkey.u12100069.wl070.sendgrid.net"
    },
    {
      name    = "uo7y2yqujn3utbzkkb4igs6irxlqozmf._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "uo7y2yqujn3utbzkkb4igs6irxlqozmf.dkim.amazonses.com"
    },
    {
      name    = "assets",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d34tpyd4up8e4j.cloudfront.net"
    },
    {
      name    = "cloud",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "go.pardot.com"
    },
    {
      name    = "community",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "zsupw73743.lithium.com"
    },
    {
      name    = "4i6erhepmezi.community",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "gv-vqrzfzp5jml767.dv.googlehosted.com"
    },
    {
      name    = "w7qhqhyrfq5h.communitymail",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "gv-ypsd3resh6onop.dv.googlehosted.com"
    },
    {
      name    = "communitystage",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "zsupw73743.stage.lithium.com"
    },
    {
      name    = "console-backup",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "classic-console-backup-1073702737.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "daas",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "go.pardot.com"
    },
    {
      name    = "demo",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d38yxozcjb68y3.cloudfront.net"
    },
    {
      name    = "_d21b7f7fe0a7da98155f2b96ee86ae4d.demo",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "_95905cda44f586533206930d56ea9376.kirrbxfjtw.acm-validations.aws"
    },
    {
      name    = "docs",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "thejumpcloud.github.io"
    },
    {
      name    = "hello",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "6c525c9f-1d46-457b-816a-6c1cd018c9a3.outrch.com"
    },
    {
      name    = "helpdesk",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "customer-sdpondemand.manageengine.com"
    },
    {
      name    = "mulesoft-api-dev",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud-nonprod-dlb.lb.anypointdns.net"
    },
    {
      name    = "mulesoft-api",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud-prod-dlb.lb.anypointdns.net"
    },
    {
      name    = "mulesoft-api-qa",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud-nonprod-dlb.lb.anypointdns.net"
    },
    {
      name    = "newton",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "u2555077.wl078.sendgrid.net"
    },
    {
      name    = "sales",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "custom-tracking.salesloft.com"
    },
    {
      name    = "segment",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "ddicegrfxscy3.cloudfront.net"
    },
    {
      name    = "stage2-kickstart",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-priv-80762458.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "staging-sso",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "staging-sso-jumpcloud-com-1641889118.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "static",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "static.jumpcloud.com.s3.amazonaws.com"
    },
    {
      name    = "status",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "nflr6k3n1c0h.stspg-customer.com"
    },
    {
      name    = "statuspage-notifications",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "u12100069.wl070.sendgrid.net"
    },
    {
      name    = "support",
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "support.jumpcloud.com.00dg0000000jusyma2.live.siteforce.com"
    },
    {
      name    = "nrxzskeboxtp.support",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "gv-v62jp75esvc3fm.dv.googlehosted.com"
    },
    {
      name    = "test-sso",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "test-sso-jumpcloud-com-1449567499.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "515119.test",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "sendgrid.net"
    },
    {
      name    = "s1._domainkey.test",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "s1.domainkey.u515119.wl120.sendgrid.net"
    },
    {
      name    = "s2._domainkey.test",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "s2.domainkey.u515119.wl120.sendgrid.net"
    },
    {
      name    = "em5874.test",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "u515119.wl120.sendgrid.net"
    },
    {
      name    = "thirdparty",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d1zz2n9wwwifeh.cloudfront.net"
    },
    {
      name    = "515119.tr",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "sendgrid.net"
    },
    {
      name    = "s1._domainkey.tr",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "s1.domainkey.u515119.wl120.sendgrid.net"
    },
    {
      name    = "s2._domainkey.tr",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "s2.domainkey.u515119.wl120.sendgrid.net"
    },
    {
      name    = "em.tr",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "u515119.wl120.sendgrid.net"
    },
    {
      name    = "university",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud.thinkific.com"
    },
    {
      name    = "zb14758130",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "domain.zoho.com"
    },
    {
      name    = "rd-bounce.jumpcloud.com",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "pm.mtasv.net"
    }
  ]

  prd_misc_records = [
    {
      name    = "6d0782f5-82d5-4106-a675-1095be8cee23"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "intercom-domain-validation=c13579eb-d977-4fb8-addc-9bc8da5c1bf1"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "MS=ms60341697"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "docker-verification=dc27aefc-fdce-4cda-8be8-ee3792ab25d7"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "docusign=97988400-ba87-45ce-af9d-c12fcba2eb30"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "00dg0000000jusyma2"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "apple-domain-verification=T2kDmjmutRnHcBwJ"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "google-site-verification=OVH-nf622AF6JVSC49PR_nwU50w-9AoskX-oyTCzCoY"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "mongodb-site-verification=sQTETMZ1NBS8MxdjoHZowywB56OjQOAL"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "pardot876401=925d26cf398317c201a38d2521074b25d5544b9b41a44339862494fd8a69abdb"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "pardot876401=b67cb78a7919e17e35bdfc0f418eee0ad75889c61f0d9f08435be858071da6ed"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "teamviewer-sso-verification=6598ee28a09f4163a0de02d66ccd1100"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "atlassian-domain-verification=S7cYemHK6CEnnMSf+rh0HwhhCEhj18DbxhqgfQ3+FzKOqahD77KJvLx1bpfD3VHG"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "keybase-site-verification=7zIYg7WmRMTATjxDjmsyfZ1mDSQt32qvLLqueITtRWc"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "v=spf1 ip4:198.37.147.129 ip4:198.21.2.137 include:et._spf.pardot.com include:mktomail.com include:_spf.google.com include:spf.zoho.com include:stspg-customer.com include:_spf.salesforce.com ~all"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "status-page-domain-verification=95l12jw930wv"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "parallels-domain-verification=c0a2e2f21d3b4596bf1d3d4343742f884857fb73731b49c7b84743ee547e2273"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "logmein-verification-code=6a06269f-6f04-4654-8c79-efc3e1a49bae"
    },
    {
      name    = "_a9f8329f3584aad9227bb86608621e5d"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "_19abd859afb0c35551051b4d62e878e2.mhbtsbpdnt.acm-validations.aws"
    },
    {
      name    = "_1224b1e8c85805b66cf6c7468ddfea44.www"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "_68400cbb487e0775d04d40935052235f.mhbtsbpdnt.acm-validations.aws"
    },
    {
      name    = "200608._domainkey"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGoQCNwAQdJBy23MrShs1EuHqK/dtDC33QrTqgWd9CJmtM3CK2ZiTYugkhcxnkEtGbzg+IJqcDRNkZHyoRezTf6QbinBB2dbyANEuwKI5DVRBFowQOj9zvM3IvxAEboMlb0szUjAoML94HOkKuGuCkdZ1gbVEi3GcVwrIQphal1QIDAQAB;"
    },
    {
      name    = "20160415172154pm._domainkey"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSorqsTRz+OZoZDnIDLhuArKEg67rbGszbfUSJJT/WbJeQq0ROo2j5n+QhQHr84NRH0ZAF7T918iMsnRTsBC+WGP/LMW3q8ioaAMqA8sBBrx7o9Krl+pc+l9NBOTQXiuGty5+bpxAiZ1aX3pHNVG3CouTQ4PjXfB/KPOhLgqu5EQIDAQAB"
    },
    {
      name    = "_amazonses"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "VIyyasRgolHqDFIq1WTqSPY/kSbZyxqjiuUx5e5aRjQ="
    },
    {
      name    = "communitymail"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "v=spf1 include:us.khoros-mail.com -all"
    },
    {
      name    = "_dashlane-challenge"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "7f4a61be9f56090225bc52db85cb313fe4518a180ec9015a700e074afd29cb59"
    },
    {
      name    = "_dmarc.communitymail"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "v=DMARC1;p=none;"
    },
    {
      name    = "_dmarc"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "v=DMARC1; p=quarantine; pct=100; rua=mailto:re+wmjldel3qjv@dmarc.postmarkapp.com; aspf=r;"
    },
    {
      name    = "_domainkey"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "t=y; o=~;"
    },
    {
      name    = "dzc"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "MWYergCg"
    },
    {
      name    = "f1._domainkey"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDcPX7U+eq4kNe12nI5LbYAjjcy3S5XqX/24bhdb7SGHD20/p7E94V8x33YbaXSdkFNKf9RZLkJ6ePFfeSwGI8iBv7vHoijNXGIcP5G9nUCoMxERixViwyz5mceJV/ap/pl9BGayx7TI44TZHCvCGm1z4EmWS/ulextYEfD5uYoCQIDAQAB"
    },
    {
      name    = "_github-pages-challenge-thejumpcloud.docs"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "9f7e17ffd85d95aa71c833fe3fb6b6"
    },
    {
      name    = "google._domainkey"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgdCANvNf4qNowdE3mVwU21s3p9PELOh7vtPvdMCUHn0XNQNZfmUmPMeEdz3a9w+EJLJXAZpUEwcB8cIyuEEBNIfZbdYXUL5vap9zGeZuetUFjEkgBiQa1R4WFzmvmmYwxAmP68qJuiUNEvmwZku5PGYmyigm29KejfsDdvz2+RwIDAQAB"
    },
    {
      name    = "google._domainkey.get"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCRTawG9K7tHX1tAzhyZtAu8MYsyTKRrm0oe2Sat+yT61AYPKeKXUfySU09bV2z3OWLmtzXQ3LoXadbfc4hrjPYNa6JRwkHyCy6tQz0MAhfECfg8p97TzbVu8JoAtB7LmrJsYd1EOuzriwBeOuBtTVmVWxqyxZYHuOe1vN8hZQ7KwIDAQAB"
    },
    {
      name    = "mx._domainkey"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVXQyHMQz4LImo8bL2ESQ46Xee8N/DS5FW2DRBganCn6q+t5ameB7D3FEKp5SOFDuWld/vrrCQDCX93vbULTKFrdyxgoJGjBLHd4Y3TKo13Mon2KGO5KZvueCiHb2AV3Y8kAFFfXWEVk/lVx0XiZtq4ZfEy+KaYWqqBxwYq8HLsQIDAQAB"
    },
    {
      name    = "smtpapi._domainkey.email"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"
    },
    {
      name    = "smtpapi._domainkey"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"
    },
    {
      name    = "get"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "google-site-verification=r08R9Bf1v1aOENAAczb6YfRGr6QQt8FvsRoRFl_ySpI"
    },
    {
      name    = "get"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "v=spf1 include:sendgrid.net include:_spf.google.com ~all"
    },
    {
      name    = "20220728194105pm._domainkey.jumpcloud.com"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCC7AFqc+rf9Wuw58oNK9KSVhUE2pDjheFtxX3u2ERVmUlVKajAL+Se31KBkdCKoyJffY+t8aYSOqL0bH5lnZdcE2XLlyGddss8h+eWf3gA/9LkXR6P31ueCpjEKzw30xKucEwPDPeJ+Ev2qBNASmrNZb51BXAl6d4YNBMOK1Dy9QIDAQAB"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "dropbox-domain-verification=occqhm6u85bf"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 86400
      type    = "TXT"
      value   = "miro-verification=d022728b62b296c83866c49d972c1c7760d7a63e"
    },
    {
      name    = "_github-challenge-jumpcloud-ent"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "921bcc58ad"
    }
  ]

  zercurity_tmp_records = [
    {
      name    = "zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "d6512e5frv0jf.cloudfront.net"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 1,
      ttl      = 1,
      type     = "MX",
      value    = "aspmx.l.google.com"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 5,
      ttl      = 1,
      type     = "MX",
      value    = "alt1.aspmx.l.google.com"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 5,
      ttl      = 1,
      type     = "MX",
      value    = "alt2.aspmx.l.google.com"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 10,
      ttl      = 1,
      type     = "MX",
      value    = "aspmx2.googlemail.com"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 10,
      ttl      = 1,
      type     = "MX",
      value    = "aspmx3.googlemail.com"
    },
    {
      name    = "zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "v=spf1 include:_spf.google.com include:amazonses.com ~all"
    },
    {
      name    = "3h3soob5dcpv.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "gv-xhkn6hzuogrb4z.dv.googlehosted.com"
    },
    {
      name    = "7nemo7skq76u.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "gv-ycohatinxsnuir.dv.googlehosted.com"
    },
    {
      name    = "_amazonses.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "oqBEcdoMWCpvqalNakfOj8IyHpeX2pDp8C4r5HwsOwc="
    },
    {
      name    = "_dmarc.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "v=DMARC1; p=quarantine; pct=20; rua=mailto:admin@zercurity.com; sp=reject; aspf=r"
    },
    {
      name    = "77bqigdckkv6gcrbehst4bpb5ymitf3v._domainkey.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "77bqigdckkv6gcrbehst4bpb5ymitf3v.dkim.amazonses.com"
    },
    {
      name    = "google._domainkey.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCBOI5GqHDkXyPJgpy8RKx54xnqparuVM/r89h0AbVwyI/AH35xSWNtPt0o0kZjW2zhd6ULZVodSov0llFfWkttfzsXSRjZa+uIr3yKKedH9hCFy9a/67vBWK8pjGW+g2nlJfNTTRRn26DiQZcvv1bNpyooouSnZ5v1swRQPLkbDQIDAQAB"
    },
    {
      name    = "lus3623kjx5wvmcrk25fq4gsoe4h3dxe._domainkey.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "lus3623kjx5wvmcrk25fq4gsoe4h3dxe.dkim.amazonses.com"
    },
    {
      name    = "orajezzoo3b477kduh5mk4r4umcpqlpz._domainkey.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "orajezzoo3b477kduh5mk4r4umcpqlpz.dkim.amazonses.com"
    },
    {
      name    = "api.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "35.157.226.4"
    },
    {
      name    = "app.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "dcnxy99tjmi0x.cloudfront.net"
    },
    {
      name    = "atlassian-connect.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "35.157.226.4"
    },
    {
      name    = "cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "185.219.110.194"
    },
    {
      name    = "cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "90.255.245.155"
    },
    {
      name    = "api.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "90.255.245.155"
    },
    {
      name    = "api.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "185.219.110.194"
    },
    {
      name    = "app.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "90.255.245.155"
    },
    {
      name    = "app.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "185.219.110.194"
    },
    {
      name    = "052.debian11-ghcr-testing.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "10.63.15.243"
    },
    {
      name    = "download.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "90.255.245.155"
    },
    {
      name    = "download.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "185.219.110.194"
    },
    {
      name    = "lb.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "cm1.zercurity.com"
    },
    {
      name    = "052.ubuntu20-ghcr-testing.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "10.63.15.236"
    },
    {
      name    = "052.ubuntu21-ghcr-testing.cm1.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "10.63.15.220"
    },
    {
      name    = "phabricator.corp.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "118.127.15.86"
    },
    {
      name    = "crm.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "118.127.15.92"
    },
    {
      name    = "data.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "185.219.110.194"
    },
    {
      name    = "data.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "90.255.245.155"
    },
    {
      name    = "deadpool.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "52.59.150.178"
    },
    {
      name    = "debian11-ghcr-testing.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "10.63.15.243"
    },
    {
      name    = "052.debian11-ghcr-testing.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "10.63.15.243"
    },
    {
      name    = "api.dev.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "35.157.226.4"
    },
    # {
    #   name     = "app.dev.zercurity.com",
    #   proxied  = false,
    #   ttl      = 1,
    #   type     = "A",
    #   value    = "d1qkbfnpnyfkrk.cloudfront.net"
    # },
    # {
    #   name     = "download.dev.zercurity.com",
    #   proxied  = false,
    #   ttl      = 1,
    #   type     = "A",
    #   value    = "d33s9uw8o40pbf.cloudfront.net"
    # },
    # {
    #   name     = "repo.dev.zercurity.com",
    #   proxied  = false,
    #   ttl      = 1,
    #   type     = "A",
    #   value    = "d2h4pwxqy718zm.cloudfront.net"
    # },
    {
      name    = "docs.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "dpdk4xh1u6rui.cloudfront.net"
    },
    {
      name    = "download.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "cm1.zercurity.com"
    },
    {
      name    = "ecr.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "35.157.226.4"
    },
    {
      name    = "_amazonses.local.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "MylgyF1WZxtqhEhyksv1cCMhEmY595TqWcKgfCbBBOM="
    },
    {
      name    = "7gieaujyeeacv3fzcrhkr3rkgbpmusok._domainkey.local.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "7gieaujyeeacv3fzcrhkr3rkgbpmusok.dkim.amazonses.com"
    },
    {
      name    = "h7wn5ux2fqe6x4zuklqz43odrmql5cjs._domainkey.local.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "h7wn5ux2fqe6x4zuklqz43odrmql5cjs.dkim.amazonses.com"
    },
    {
      name    = "mhjazwbfwcee6pk4ez2ayo6qfddox2qd._domainkey.local.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "mhjazwbfwcee6pk4ez2ayo6qfddox2qd.dkim.amazonses.com"
    },
    {
      name    = "api.local.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "cm1.zercurity.com"
    },
    {
      name    = "app.local.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "cm1.zercurity.com"
    },
    {
      name    = "download.local.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "cm1.zercurity.com"
    },
    {
      name    = "mautic.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "118.127.15.92"
    },
    {
      name    = "_f2d6a8a5dc7e14f1251f1b324313159f.api.nightly.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "_a966113f0b750d8985a5605cdeb71865.duyqrilejt.acm-validations.aws"
    },
    {
      name    = "repo.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "d2h4pwxqy718zm.cloudfront.net"
    },
    {
      name    = "sentry.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "cm1.zercurity.com"
    },
    {
      name    = "syslog.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "A",
      value   = "192.168.1.110"
    },
    {
      name     = "workflows.zercurity.com",
      proxied  = false,
      priority = 10,
      ttl      = 1,
      type     = "MX",
      value    = "inbound-smtp.eu-west-1.amazonaws.com"
    },
    {
      name    = "_amazonses.workflows.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "vKZqDBXnfCxp9AY/gIxzo2WC8+Cn0qHQWcu/3EGLT7k="
    },
    {
      name    = "7flff6wffkonj7drn7u7rqypp4dsvmkn._domainkey.workflows.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "7flff6wffkonj7drn7u7rqypp4dsvmkn.dkim.amazonses.com"
    },
    {
      name    = "g4l5u4m647hfrnpabyhopdluey4tulcd._domainkey.workflows.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "g4l5u4m647hfrnpabyhopdluey4tulcd.dkim.amazonses.com"
    },
    {
      name    = "u2jcxqn3vz3yws3cwccaajfvk267yquo._domainkey.workflows.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "u2jcxqn3vz3yws3cwccaajfvk267yquo.dkim.amazonses.com"
    },
    {
      name    = "ww2.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "s3-website.eu-central-1.amazonaws.com"
    },
    {
      name    = "ww3.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "s3-website.eu-central-1.amazonaws.com"
    },
    {
      name    = "www.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "d2s0xzif3whxwe.cloudfront.net"
    }
  ]

  prd_dns_records = concat(local.prd_a_records, local.prd_mx_records, local.prd_cname_records, local.prd_misc_records)
}
