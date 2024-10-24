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
  cloudflare_zones = concat([
    "id.jumpcloud.com",
    "id.stg01.jumpcloud.com",
    "jumpcloudlounge.com",
    "zercurity.com",
    "jumpcloud.ai",
  ], local.resmo_zones[*].name)

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
    // START - Marketing website
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
    {
      name    = "ti-1",
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "44.239.47.105"
    },
    {
      name    = "ti-2",
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "52.13.15.220"
    },
    // END - Marketing website
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
      value   = "adbridge-kickstart.prd-use1.jcplatform.dev"
    },
    {
      name    = "adbridge"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge.prd-use1.jcplatform.dev"
    },
    {
      name    = "agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "agent.prd-use1.jcplatform.dev"
    },
    {
      name    = "api"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "api.prd-use1.jcplatform.dev"
    },
    {
      name    = "assist"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "assist.prd-use1.jcplatform.dev"
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
      value   = "si-bss-api.prd-use1.jcplatform.dev"
    },
    {
      name    = "console"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "console.prd-use1.jcplatform.dev"
    },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert.prd-use1.jcplatform.dev"
    },
    {
      name    = "kickstart"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public.prd-use1.jcplatform.dev"
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
      value   = "go.prd-use1.jcplatform.dev"
    },
    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private.prd-use1.jcplatform.dev"
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
      value   = "login-api.prd-use1.jcplatform.dev"
    },
    {
      name    = "nli"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli-haproxy.ue1-prd-p01.jcplatform.dev"
    },
    {
      name    = "oauth"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth.prd-use1.jcplatform.dev"
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso.prd-use1.jcplatform.dev"
    },
    {
      name    = "saas"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "saas.prd-use1.jcplatform.dev"
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
      name    = "prd02-mulesoft-api",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "jumpcloud-prod-dlb.lb.anypointdns.net"
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
    },
    {
      name    = "www.jumpcademy.com",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "lmso9s9e0x724u0quekaz9s8i5i0s05ko.lb1.wl.lmspowered.com"
    },
    // START - Catalyst
    {
      name    = "url9805",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "sendgrid.net"
    },
    {
      name    = "19687090",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "sendgrid.net"
    },
    {
      name    = "em3336",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "u19687090.wl091.sendgrid.net"
    },
    {
      name    = "JUM._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "JUM.domainkey.u19687090.wl091.sendgrid.net"
    },
    {
      name    = "JUM2._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "JUM2.domainkey.u19687090.wl091.sendgrid.n"
    },
    // END - Catalyst
    {
      name    = "*.devices.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value = "pwm-haproxy.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.grpc.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value = "pwm-haproxy.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.scim.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value = "pwm-haproxy.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.scim.pwm"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value = "pwm-haproxy.prd-use1.jcplatform.dev"
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
      value   = "v=spf1 redirect=92a9d6451b5c81c4b4f330465322362ff9ecd73b94ef247be6bdb1ca.us.rspf.letsdmarc.com"
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
      ttl     = 3600
      type    = "TXT"
      value   = "v=DMARC1; p=quarantine; aspf=r; pct=100; rua=mailto:rua_38b6f6b37e6ff565@us.report.letsdmarc.com,mailto:re+wmjldel3qjv@dmarc.postmarkapp.com"
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
    },
    {
      name    = "@"
      proxied = false
      ttl     = 86400
      type    = "TXT"
      value   = "hcp-domain-verification=712881902e3616442a1859ed3b8c120f22f3acf5ac0c14d1c1c0f521d283398b"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 86400
      type    = "TXT"
      value   = "hcp-domain-verification=0e8f600d72e9adbfec509b1b78935b1e364e46eee9dda823c9bfd977379e8551"
    },
    {
      name    = "_letsdmarc.jumpcloud.com."
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "a6c6f863eacc4d5f41f52f55678f18f38187fbb3db3888926181045efb0fcf0baa9b528fc943970ff9a41c6aca37bcb9d0bbb02387addf53bf13b69c042abb3c"
    },
  ]

  zercurity_tmp_records = [
    {
      name    = "zercurity.com",
      proxied = true,
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
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "app.zercurity.com",
      proxied = true,
      ttl     = 1,
      type    = "CNAME",
      value   = "dcnxy99tjmi0x.cloudfront.net"
    },
    {
      name    = "atlassian-connect.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "cm1.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "data.zercurity.com",
      proxied = true,
      ttl     = 1,
      type    = "CNAME",
      value   = "dpdk4xh1u6rui.cloudfront.net"
    },
    {
      name    = "docs.zercurity.com",
      proxied = true,
      ttl     = 1,
      type    = "CNAME",
      value   = "dpdk4xh1u6rui.cloudfront.net"
    },
    {
      name    = "download.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "ecr.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "repo.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "sentry.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "www.zercurity.com",
      proxied = true,
      ttl     = 1,
      type    = "CNAME",
      value   = "d2s0xzif3whxwe.cloudfront.net"
    }
  ]

  jumpcloud_ai_tmp_records = [
    {
      name    = "jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli-haproxy.ue1-prd-p01.jcplatform.dev"
    },
    {
      name     = "jumpcloud.ai."
      proxied  = false
      ttl      = 300
      type     = "MX"
      value    = "inbound-smtp.us-west-2.amazonaws.com."
      priority = 10
    },

    {
      name    = "jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "\"v=spf1 include:amazonses.com ~all\""
    },
    {
      name    = "_6118e8f680ff20142507a919f01f02f2.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "_54c0ce4eff1b5c1d64535548f6532a91.nrbkhpnbdq.acm-validations.aws."
    },
    {
      name    = "_amazonses.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "\"tZG3EExPo9JuOKS7z9FyzjOrdo09J4SiwP9GXiskwlU=\""
    },
    {
      name    = "_dmarc.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "\"v=DMARC1;p=quarantine;pct=100;fo=1\""
    },
    # Domain Keys used for email
    {
      name    = "3p3wbyropt6azbu6ksmg4q5usw3mup2l._domainkey.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "3p3wbyropt6azbu6ksmg4q5usw3mup2l.dkim.amazonses.com."
    },
    {
      name    = "emznfl5kmth37sksl7q3sb72s25yemrp._domainkey.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "emznfl5kmth37sksl7q3sb72s25yemrp.dkim.amazonses.com."
    },
    {
      name    = "qwakdshufxtgact5zc6x3tviexz4gar4._domainkey.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "qwakdshufxtgact5zc6x3tviexz4gar4.dkim.amazonses.com."
    },
    {
      name    = "autodiscover.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "autodiscover.mail.us-west-2.awsapps.com."
    },
    {
      name    = "labs.jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "44.216.106.214"
    },
    {
      name    = "stg01.jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli.stg01.jumpcloud.com"
    },
    {
      name    = "labs.stg01.jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "44.216.106.214"
    },
    {
      name    = "www.jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud.ai"
    },
    {
      name    = "_3962e45834f0472e0e68df6299a3430d.www.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "_dba5a7fcc698fc0d1dbd24e71013ce00.nrbkhpnbdq.acm-validations.aws."
    }
  ]

  prd_dns_records = concat(local.prd_a_records, local.prd_mx_records, local.prd_cname_records, local.prd_misc_records)

  resmo_zones = [
    {
      name = "resmo.com"
      dns_records = [
        # A records
        {
          name    = "resmo.com"
          proxied = true
          ttl     = 1
          type    = "A"
          value   = "75.2.70.75"
        },
        {
          name    = "resmo.com"
          proxied = true
          ttl     = 1
          type    = "A"
          value   = "99.83.190.102"
        },

        # CNAME records
        {
          # was alias A record in aws
          name    = "app"
          proxied = false
          ttl     = 60
          type    = "CNAME"
          value   = "d1b3fscmxwb4xc.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "browser"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "d1ogzvyyqrr4l5.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "id"
          proxied = false
          ttl     = 60
          type    = "CNAME"
          value   = "d1b3fscmxwb4xc.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "login"
          proxied = false
          ttl     = 60
          type    = "CNAME"
          value   = "d1b3fscmxwb4xc.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "static"
          proxied = false
          ttl     = 60
          type    = "CNAME"
          value   = "dfbrjj3fnyucv.cloudfront.net"
        },
        {
          name    = "_680d782af04216a8b61c51bac7cc7bbc"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "_977e3564c47b7c7b216b1454a6648e87.xrchbtpdjs.acm-validations.aws."
        },
        {
          name    = "_8cfeba28edf6dad058356ccf166c98ea"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "_f58085647f4f8d452e910c8721c8cad4.mntkzmhvxg.acm-validations.aws."
        },
        {
          name    = "4u6mxursrjjt3aze3rcr5prxokcxejrs._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "4u6mxursrjjt3aze3rcr5prxokcxejrs.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "c4oloqlctkaw26sz54662idkxubnpq65._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "c4oloqlctkaw26sz54662idkxubnpq65.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "c5fgs4xwcbjrygwkc2rwnsddrivnzdom._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "c5fgs4xwcbjrygwkc2rwnsddrivnzdom.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "fchynlnz357ydlo3jwdxags2lezzgp3z._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "fchynlnz357ydlo3jwdxags2lezzgp3z.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "hs1-22352923._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "resmo-com.hs14a.dkim.hubspotemail.net."
        },
        {
          name    = "hs2-22352923._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "resmo-com.hs14b.dkim.hubspotemail.net."
        },
        {
          name    = "intercom._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "9c748959-eb77-42fd-9764-aff648a230bb.dkim.intercom.io."
        },
        {
          name    = "nghohojb7jd2zujpgk35gob7zqfnwfga._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "nghohojb7jd2zujpgk35gob7zqfnwfga.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "oecdx2ii6zt26yrrik35xttxz6ar4sqy._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "oecdx2ii6zt26yrrik35xttxz6ar4sqy.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "pd1._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "pd1.pdrserv.com"
        },
        {
          name    = "pd2._domainkey.resmo.com"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "pd2.pdrserv.com"
        },
        {
          name    = "blog-test"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "22352923.group23.sites.hubspot.net"
        },
        {
          name    = "bounce"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "custom-email-domain.stripe.com"
        },
        {
          name    = "changelog"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "cname.announcekit.app"
        },
        {
          name    = "docs.resmo.com."
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "b3ed3db57d-hosting.gitbook.io"
        },
        {
          name    = "email-test"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "22352923.group23.sites.hubspot.net"
        },
        {
          name    = "emails"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "aplolinks.com"
        },
        {
          name    = "outbound.intercom"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "rp.resmo.intercom-mail.com"
        },
        {
          name    = "landing-test"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "22352923.group23.sites.hubspot.net"
        },
        {
          name    = "resources"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "b3ed3db57d-hosting.gitbook.io"
        },
        {
          name    = "trust"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "custom.trustpage.app"
        },
        {
          name    = "_acme-challenge.trust"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "skyk14zsti65zvrkyc.fastly-validations.com"
        },
        {
          name    = "www"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "proxy-ssl.webflow.com"
        },

        # TXT Records
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "google-site-verification=ICo5Fg_M7RNVfh2XGkMuwGJh2MHgfJsHDCQ9UCb5x1s"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "atlassian-domain-verification=1sRYQtar/Fxm3JcAe4uVui38xaPxcJIKxOmp/bteFurxTJgwElFO6RKaXdWZI5Nx"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "google-site-verification=TH4-NfM4VQXiDPQg5qGrPYp884ZqpHYqij6wdfnXv84"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "stripe-verification=e21f4376ad23e3d9e89a34364cae78898d107fe720e49ece3a4043fa2a6aa47a"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=spf1 include:_spf.google.com -all"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "MS=DFFC3541DF0EBDB98D1E45852D1AF2557CE235EB"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "google-site-verification=34Bi68IcTETgPnQErlWcTjTZLuGwmWVCSiRnWLf8TmI"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "hubspot-developer-verification=M2NjNDljYmQtYmI0OS00OGUyLTk5ZmUtZjcwYzBmZmEyYjk0"
        },
        {
          name    = "_dmarc"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=DMARC1;p=none;pct=100;rua=mailto:dmarc.feedback@resmo.com;"
        },
        {
          name    = "google._domainkey"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA61Ij2n3QfT9cbc7uYPS/DAapgJ3OKKViqIl+nAtKVLslD7t1qac3+dJHHf1YMlyDWPFLQb4OTUwR58+WTmZ8MnVD7FKcrh6tHUW+4iy61WqzJYaZ33A/HIuUj1ENNihZ9BDqzei/m8zIeEVwzza/T60YlywInoLBIlIgNUDpYS0Gr3Fnd2kmNbsi9hR96cvXYXKM0tYR8q67JO1dRbWvBcTq1Tjk3C46G3HgrIaShtl0mTr2JqeWVE7qWeUOJbhAdizU2u1gL6b2RBay/qmZCGssfEYa6lU5yQiVMBFu0gw8MncXFf1yX88m9bhCun94adnskuuTaL/FzxmmDdAhPwIDAQAB"
        },
        {
          name    = "_github-challenge-resmoio-organization"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "dca392dafe"
        },
        {
          name    = "_pdcid"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "gjkZ-FMFl9DvYoZmBZBvi3Rw3NpC_9t7R2A5SZYtFdtCiuEZ"
        },
        {
          name    = "_github-challenge-resmoio-organization.www"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "6c9d0182b5"
        },

        # MX Records
        {
          name     = "@"
          priority = 1
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 5
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt1.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 5
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt2.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 10
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt3.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 10
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt4.aspmx.l.google.com"
        }
      ]
    },
    {
      name = "resmo.io"
      dns_records = [
        # A records
        {
          name    = "resmo.io"
          proxied = false
          ttl     = 300
          type    = "A"
          value   = "75.2.70.75"
        },
        {
          name    = "resmo.io"
          proxied = false
          ttl     = 300
          type    = "A"
          value   = "99.83.190.102"
        },
        {
          name    = "dev"
          proxied = false
          ttl     = 300
          type    = "A"
          value   = "127.0.0.1"
        },
        {
          name    = "052.dev"
          proxied = false
          ttl     = 300
          type    = "A"
          value   = "127.0.0.1"
        },

        #CNAME Records
        {
          # was alias A record in aws
          name    = "apis"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "dualstack.resmo-api-1826250524.us-west-2.elb.amazonaws.com"
        },
        {
          # was alias A record in aws
          name    = "lb"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "dualstack.resmo-api-1826250524.us-west-2.elb.amazonaws.com"
        },
        {
          name    = "_5e49427239f47d6873989c00feb431bb"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "_22c0c5f44b7c37145ea0d5dfd81c94cf.bbfvkzsszw.acm-validations.aws."
        },
        {
          name    = "4elayc3ht45v7lfewmqhi3jpebchvmcq._domainkey"
          proxied = false
          ttl     = 1800
          type    = "CNAME"
          value   = "4elayc3ht45v7lfewmqhi3jpebchvmcq.dkim.amazonses.com"
        },
        {
          name    = "m3kttf5jyddzw3snmrdq3ba6hkqorciv._domainkey"
          proxied = false
          ttl     = 1800
          type    = "CNAME"
          value   = "m3kttf5jyddzw3snmrdq3ba6hkqorciv.dkim.amazonses.com"
        },
        {
          name    = "xlazj5vmv7dgxjwa2wwjnjorgwliwv66._domainkey"
          proxied = false
          ttl     = 1800
          type    = "CNAME"
          value   = "xlazj5vmv7dgxjwa2wwjnjorgwliwv66.dkim.amazonses.com"
        },
        {
          name    = "app"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "d11qqtz2abv5n8.cloudfront.net"
        },
        {
          name    = "www",
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "proxy-ssl.webflow.com"
        },

        # TXT Records
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "google-site-verification=iuX5A-PjgAM_36ZSOLDuH9Ts_I3euoiyxy2g_puppaQ"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=spf1 include:_spf.google.com -all"
        },
        {
          name    = "_amazonses"
          proxied = false
          ttl     = 1800
          type    = "TXT"
          value   = "BkjK9oKpWMsRtisrTQGhFWGswGTzydJpEBj1/DYb/z0="
        },
        {
          name    = "_dmarc"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=DMARC1;p=none;pct=100;"
        },
        {
          name    = "google._domainkey"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAn3w+v/HqDBTwwPC73u6/mJLsRruoUCQ0VgJK1DUZ/GrXv20Lp4MrCRAycSrp9GtdNeRTRZjoNrNbX/nAjrIARs296MO2/hRT+AGZ6VGYnS0MVeGP1k1sHdM5iWEphximArt4JuOcwHL46H204949VOyc0Tp9IJux51JgdV3hIia4Ib36oWc8GGhlM77eNIcZ8A8xQJCjjGpY1W1cyfxATKlXPiHGds+b02Z1Pj++H4R0jcpDSheI4YyvJ5kpWeP3elTTwRgPaOQCGipaZDCw80EzGnDg4IsYWkmqeZ78u98I7DmYQhuDyHzk7EDGFYY3+ltWHYV10FNeMaq4XsxjSQIDAQAB"
        },
        # MX Records
        {
          name     = "@"
          priority = 1
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 5
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt1.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 5
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt2.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 10
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt3.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 10
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt4.aspmx.l.google.com"
        }
      ]
    },
    {
      name = "resmo.app"
      dns_records = [
        # CNAMES
        {
          name    = "*.resmo.app"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "d1ky3ow4gqkauh.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "resmo.app",
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "d1ky3ow4gqkauh.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "grafana"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "dualstack.resmo-grafana-ops-341763830.us-west-2.elb.amazonaws.com"
        },
        {
          name    = "052"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "d1ky3ow4gqkauh.cloudfront.net"
        },
        {
          name    = "_4e5ac150de979056132304cf83704450"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "_563c3d7ccf609babfe1d4cba3f82b93f.wrncprvrjv.acm-validations.aws."
        },
        {
          name    = "foncza73g3xshuzfqfy6x5pfhxhjvup6._domainkey"
          proxied = false
          ttl     = 1800
          type    = "CNAME"
          value   = "foncza73g3xshuzfqfy6x5pfhxhjvup6.dkim.amazonses.com"
        },
        {
          name    = "lqlmwlk35zzjpvcjdvnli2e6mtfm7agr._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "lqlmwlk35zzjpvcjdvnli2e6mtfm7agr.dkim.amazonses.com"
        },
        {
          name    = "nm7ab7dp77azce3w6k5hkee26ibqlwy3._domainkey"
          proxied = false
          ttl     = 1800
          type    = "CNAME"
          value   = "nm7ab7dp77azce3w6k5hkee26ibqlwy3.dkim.amazonses.com"
        },
        {
          name    = "_2f0b119180a09a49eff251cf2537bae7.vpn"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "_7a63e7194b358562a55d86ef6d6388f8.mntkzmhvxg.acm-validations.aws."
        },

        # TXT Records
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "google-site-verification=R_5_eRVnqhEf2FExzjfaPMtX0sAhZrTLY2aO7ofyWm8"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=spf1 -all"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "zoom-domain-verification=9280175d-5c91-4b33-bcf9-183ae6335169"
        },
        {
          name    = "_dmarc"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=DMARC1;p=reject;pct=100;"
        },
        {
          name    = "bounce-ses"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=spf1 include:amazonses.com ~all"
        },

        # MX Records
        {
          name     = "bounce-ses"
          priority = 10
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "feedback-smtp.us-west-2.amazonses.com"
        }
      ]
    }
  ]

  resmo_zone_name_to_zone = {
    for zone in local.resmo_zones : zone.name => zone
  }
}
