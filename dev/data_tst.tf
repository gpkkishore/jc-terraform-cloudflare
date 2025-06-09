# See docs/contributing.md for information on how to add a DNS record.
# Note that there are the following arrays, and new records should be placed in the correct array
# tst_a_records     - All the A, AAAA, and ANAME records
# tst_mx_records    - All the MX records. MX records MUST be in this array as they have additional attributes
# tst_cname_records - All the CNAME records
# tst_misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)
locals {
  tst_a_records = [
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
      name    = "staging",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "54.225.98.126"
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
      name    = "ti",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "151.101.2.132"
    },
    {
      name    = "ti",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "151.101.66.132"
    },
    {
      name    = "ti",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "151.101.130.132"
    },
    {
      name    = "ti",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "151.101.194.132"
    },
    {
      name    = "titanium",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "151.101.2.132"
    },
    {
      name    = "titanium",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "151.101.66.132"
    },
    {
      name    = "titanium",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "151.101.130.132"
    },
    {
      name    = "titanium",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "151.101.194.132"
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
  ]

  tst_mx_records = [
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

  tst_cname_records = [
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
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "assist.prd-use1.jcplatform.dev"
    },
    {
      name    = "apple-mdm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.prd-use1.jcplatform.dev"
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
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-public.prd-use1.jcplatform.dev"
    },
    {
      name    = "apple.mdm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "apple-mdm.prd-use1.jcplatform.dev"
    },
    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private.prd-use1.jcplatform.dev"
    },
    {
      name    = "sso"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "sso.prd-use1.jcplatform.dev"
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
      name    = "_ec5ddd489ea1118a8fdf339eb040ca8c.assets",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "_9bf1779c886e3f8dff84c722feb8c8b9.auiqqraehs.acm-validations.aws"
    },
    {
      name    = "cdn",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d304esfcsmmapa.cloudfront.net"
    },
    {
      name    = "_e6d6616ef2dd3189f067881600a8b4de.cdn",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "_26322312694d41edb6ff975071b7ac8b.bgpjyrktby.acm-validations.aws"
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
      name    = "email",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "u817177.wl.sendgrid.net"
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
      name    = "links",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d2wpzdnpqqgnhf.cloudfront.net"
    },
    {
      name    = "_45568eea00d494e516c6c642168f901e.links",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "_e8d318c3068ae9619dd1e863e2323cf6.zdxcnfdgtt.acm-validations.aws"
    },
    {
      name    = "mulesoft-api-dev",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "y8wu2d.usa-e1.cloudhub.io"
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
      value   = "y8wu2d.usa-e1.cloudhub.io"
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
      name    = "_ce6f4c628c5c139a7c72aed4f779dc5e.segment",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "_502a7d3339d30a7d629703aee79d3c18.auiqqraehs.acm-validations.aws"
    },
    {
      name    = "segmentcdn",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "drboqiqixxsdu.cloudfront.net"
    },
    {
      name    = "_c4b3516c6ad01381f7a93f5afdd63a0e.segmentcdn",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "_095d2b3fe1091cc13b4f07602aa666ca.bwlshdtstt.acm-validations.aws"
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
      proxied = false
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
      name    = "links.test",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "dwwkmwkg0qs49.cloudfront.net"
    },
    {
      name    = "_f53885b8fdfd5ff0946f2d8a218907ab.links.test",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "_089a675d599ebf7e356d75096f66eaf5.zdxcnfdgtt.acm-validations.aws"
    },
    {
      name    = "thirdparty",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d1zz2n9wwwifeh.cloudfront.net"
    },
    {
      name    = "_1c43a89d54ecbba5174b070a2993b0fc.thirdparty",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "_2fb90b68bcadad61a727022ef68730ad.ltfvzjuylp.acm-validations.aws"
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
      name    = "links.tr",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d2w25ujs1ver8z.cloudfront.net"
    },
    {
      name    = "_ea68bad0dbad6ca638e3d732d7af47d3.links.tr",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "_581c3924c6d9323d6aa777c742fe741f.zdxcnfdgtt.acm-validations.aws"
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
      name    = "try",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "unbouncepages.com"
    },
    {
      name    = "rd-bounce.jumpcloud.com",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "pm.mtasv.net"
    }
  ]

  tst_misc_records = [
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
    }
  ]

  tst_dns_records = concat(local.tst_a_records, local.tst_mx_records, local.tst_cname_records, local.tst_misc_records)
}
