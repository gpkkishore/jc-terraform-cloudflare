# See docs/contributing.md for information on how to add a DNS record.
# Note that there are the following arrays, and new records should be placed in the correct array
# prd_a_records     - All the A, AAAA, and ANAME records
# prd_mx_records    - All the MX records. MX records MUST be in this array as they have additional attributes
# prd_cname_records - All the CNAME records
# prd_misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)
locals {
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
    },
    {
      name              = "adbridge-kickstart"
      hosts             = ["*.adbridge-kickstart.jumpcloud.com", "adbridge-kickstart.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "adbridge"
      hosts             = ["*.adbridge.jumpcloud.com", "adbridge.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "agent"
      hosts             = ["*.agent.jumpcloud.com", "agent.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "api"
      hosts             = ["*.api.jumpcloud.com", "api.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "assist"
      hosts             = ["*.assist.jumpcloud.com", "assist.jumpcloud.com"]
      validation_method = "txt"
    },
    // Creating new and removing old later
    {
      name              = "apple-mdm-wildcard"
      hosts             = ["apple-mdm.jumpcloud.com", "*.apple-mdm.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "bss"
      hosts             = ["*.bss.jumpcloud.com", "bss.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "console"
      hosts             = ["*.console.jumpcloud.com", "console.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "device-cert"
      hosts             = ["*.device-cert.jumpcloud.com", "device-cert.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "kickstart"
      hosts             = ["*.kickstart.jumpcloud.com", "kickstart.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "apple.mdm"
      hosts             = ["apple.mdm.jumpcloud.com", "*.apple.mdm.jumpcloud.com"]
      validation_method = "txt"
    },

    {
      name              = "go"
      hosts             = ["*.go.jumpcloud.com", "go.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "private-kickstart"
      hosts             = ["*.private-kickstart.jumpcloud.com", "private-kickstart.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "pwm"
      hosts             = ["*.pwm.eu.jumpcloud.com", "pwm.eu.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "login"
      hosts             = ["*.login.jumpcloud.com", "login.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "mcp"
      hosts             = ["*.mcp.jumpcloud.com", "mcp.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "mcpv2"
      hosts             = ["*.mcpv2.jumpcloud.com", "mcpv2.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "microsoft-mdm-eu"
      hosts             = ["*.microsoft-mdm.eu.jumpcloud.com", "microsoft-mdm.eu.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "nli"
      hosts             = ["*.nli.jumpcloud.com", "nli.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "oauth"
      hosts             = ["*.oauth.jumpcloud.com", "oauth.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "slack"
      hosts             = ["*.slack.jumpcloud.com", "slack.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "sso"
      hosts             = ["*.sso.jumpcloud.com", "sso.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "saas"
      hosts             = ["*.saas.jumpcloud.com", "saas.jumpcloud.com"]
      validation_method = "txt"
    },
    {
      name              = "eu"
      hosts             = ["*.eu.jumpcloud.com", "eu.jumpcloud.com", "*.id.eu.jumpcloud.com", "*.mdm.eu.jumpcloud.com"]
      validation_method = "txt"
    },
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
      proxied = false
      ttl     = 1,
      type    = "CNAME",
      value   = "www.jcops.net",
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
      name    = "prd-jumpcloud-logging-rmq-use1c-02"
      proxied = false
      ttl     = 60
      type    = "A"
      value   = "10.30.3.24"
    },
    // START - Marketing website
    // These dev/staging records are for pre-prod envs on the marketing website (hosted through lightsail)
    # staging / ti-1 / ti-2 retired — infra-edge owns brand proxied A + R53 warm path (state-rm, not destroy).
    # jcops.net: prd/jcops.tf jcops_app_dns_records.
    // END - Marketing website
    {
      name    = "tools",
      proxied = false
      ttl     = 1
      type    = "A"
      value   = "34.111.179.208"
    },
    # Retired proxied A rows (state-rm from module.dns before apply — infra-edge owns brand CF):
    #   ai, staging, ti-1, ti-2 → jcops.net: prd/jcops.tf jcops_app_dns_records
    # Retired proxied brand CNAMEs (state-rm — infra-edge owns brand CF + grey→jcops cutover):
    #   api, apple-mdm, apple.mdm, assist, console, go, jumpdesk, kickstart, login, mcp, mcpv2,
    #   microsoft-mdm, nli, oauth, ocsp, polaris, polaris-console, saas, scep, slack, ssf, sso, trino
    #   (+ matching *.<label> wildcards where present) → jcops.net: prd/jcops.tf jcops_app_dns_records
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
      name    = "adbridge-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "adbridge-kickstart.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.adbridge-kickstart"
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
      name    = "*.adbridge"
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
      name    = "*.agent"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "agent.prd-use1.jcplatform.dev"
    },
    {
      name    = "bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "si-bss-api.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.bss"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "si-bss-api.prd-use1.jcplatform.dev"
    },
    {
      name    = "device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.device-cert"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "device-cert.prd-use1.jcplatform.dev"
    },

    {
      name    = "h-9d4953e0122bf"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "h-9d4953e0122bf.prd-use1.jcplatform.dev"
    },
    {
      name    = "private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.private-kickstart"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "kickstart-private.prd-use1.jcplatform.dev"
    },
    {
      name    = "schema-registry"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "schema-registry.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.schema-registry"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "schema-registry.prd-use1.jcplatform.dev"
    },
    {
      name    = "search-api"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "search-api.prd-use1.jcplatform.dev"
    },
    {
      name    = "*.search-api"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "search-api.prd-use1.jcplatform.dev"
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
      value   = "community.jcops.net"
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
      value   = "y8wu2d.usa-e1.cloudhub.io"
    },
    {
      name    = "mulesoft-api",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "hnbh3q.usa-e1.cloudhub.io"
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
      name    = "partnermarketing",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud.publisher.impartner.io"
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
      value   = "support.jcops.net"
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
      value   = "lmsx7sxmk23m7c6vh01sl1s5ini1s980x.lb1.wl.lmspowered.com"
    },
    {
      name    = "partnerjcu",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "lmsyeso18yxkei5yaq1a65h7izi1skr86.lb1.wl.lmspowered.com"
    },
    {
      name    = "partners",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud.partner-experience.com"
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
      name    = "jumpcademy",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "lmso9s9e0x724u0quekaz9s8i5i0s05ko.lb1.wl.lmspowered.com"
    },
    {
      name    = "jcapollo",
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "encouraging-starfruit.aplosites.com"
    },
    {
      name    = "jumpcloudland",
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "sslevents.bizzabo.com"
    },
    {
      name    = "webinar",
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "sslevents.bizzabo.com"
    },
    {
      name    = "biz",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "u47372865.wl116.sendgrid.net"
    },
    {
      name    = "biz._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "biz.domainkey.u47372865.wl116.sendgrid.net"
    },
    {
      name    = "biz2._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "biz2.domainkey.u47372865.wl116.sendgrid.net"
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
      value   = "jum.domainkey.u19687090.wl091.sendgrid.net"
    },
    {
      name    = "JUM2._domainkey",
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "jum2.domainkey.u19687090.wl091.sendgrid.net"
    },
    // END - Catalyst
    // START PWM
    {
      name    = "devices.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "pwm-devices.prd-use1.jcplatform.dev"
    },
    {
      name    = "cdn.pwm"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "d37bnv0y5ohq9m.cloudfront.net"
    },
    // END PWM
    # ssf retired — infra-edge owns brand CF (was → saas.prd-use1.jcplatform.dev)
    // START ROCKETLANE
    {
      name    = "_1ed3637f5a8544a903875ba040c764c7.professionalservices"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "_200d95675b3cefb8a87dba326c877273.zfyfvmchrl.acm-validations.aws."
    },
    {
      name    = "_b98a9f2004aa428f0b1071369181db4d.professionalservices.api"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "_11e490a8484a33748d837d2942e87bd8.zfyfvmchrl.acm-validations.aws."
    },
    {
      name    = "professionalservices"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "customdomain-8.rocketlane.com"
    },
    {
      name    = "professionalservices.api"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "customdomain-8.api.rocketlane.com"
    },
    {
      name    = "em569.professionalservices.jumpcloud.com"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "19602_spf_jumpcloud.rocketlane.com"
    },
    {
      name    = "602._domainkey.professionalservices.jumpcloud.com"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "19602_dkim1_jumpcloud.rocketlane.com"
    },
    {
      name    = "6022._domainkey.professionalservices.jumpcloud.com"
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "19602_dkim2_jumpcloud.rocketlane.com"
    },
    // END ROCKETLANE
    // START MARKETO
    {
      name    = "info"
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "706-rst-100.mktoweb.com"
    },
    {
      name    = "email"
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "mkto-ab650156.com"
    },
    // END MARKETO
    {
      name    = "intercom._domainkey.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "67e0f016-d98f-42f9-981a-6347be1b9dc6.dkim.intercom.io."
    },
    {
      name    = "outbound.intercom.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "rp.jumpcloud-support.intercom-mail.com."
    },
    # START PWM VALIDATION
    {
      name    = "_421057bc09925e1ad958bb32388d4926.pwm.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "_cfd405d688523fa0a9691e07b9f01221.gfjzbhpkrq.acm-validations.aws."
    },
    {
      name    = "_ade2dd9076f3f452e005b7c0da0075e8.cdn.pwm.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "_a91e5e66fb71df666bd072660ecd6268.gfjzbhpkrq.acm-validations.aws."
    },
    # END PWM VALIDATION
    # START UNIVERSITY
    {
      name    = "em5848.em.sandbox.university"
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "u9987757.wl008.sendgrid.net"
    },
    {
      name    = "s1._domainkey.em.sandbox.university"
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "s1.domainkey.u9987757.wl008.sendgrid.net"
    },
    {
      name    = "s2._domainkey.em.sandbox.university"
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "s2.domainkey.u9987757.wl008.sendgrid.net"
    },
    {
      name    = "em4681.university.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "u817177.wl178.sendgrid.net"
    },
    {
      name    = "s1._domainkey.university.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "s1.domainkey.u817177.wl178.sendgrid.net"
    },
    {
      name    = "s2._domainkey.university.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "s2.domainkey.u817177.wl178.sendgrid.net"
    },
    # END UNIVERSITY
    # START PARTNERJCU
    {
      name    = "em8565.partnerjcu.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "u817177.wl178.sendgrid.net"
    },
    {
      name    = "s1._domainkey.partnerjcu.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "s1.domainkey.u817177.wl178.sendgrid.net"
    },
    {
      name    = "s2._domainkey.partnerjcu.jumpcloud.com."
      proxied = false
      ttl     = 60
      type    = "CNAME"
      value   = "s2.domainkey.u817177.wl178.sendgrid.net"
    },
    # END PARTNERJCU
  ]

  prd_misc_records = [
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "openai-domain-verification=dv-y8FJwLynSyHRQ5k4CRHIAs0o"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "openai-domain-verification=dv-4fAxbZtGbLBhuCwIYmAVVxGy"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "openai-domain-verification=dv-TKuxV377bSSAASWQT3Bk4VR5"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "anthropic-domain-verification-d2y1h3=hgs2t15zExm5ufddrHso0KZwW"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "pendo-domain-verification=nP--wi-vPNhIAj3UEf41veozcVU"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "google-site-verification=Lsc8IrEquKnjM6ybUEPhDzAniM6mH9gxP1Pq6JbVncE"
    },
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
      value   = "00DOy00000NXOKu=1TBOy0000000a6j"
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
      value   = "v=spf1 include:_spf.google.com redirect=92a9d6451b5c81c4b4f330465322362ff9ecd73b94ef247be6bdb1ca.us.rspf.letsdmarc.com"
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
      name    = "dev"
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "google-site-verification=GBfYlqd6boNHZE7Q0Z5a8hw-N-LIAjC8f_ZpRzSELnw"
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
      name    = "scph1125._domainkey.partners.jumpcloud.com"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "v=DKIM1; k=rsa; h=sha256; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwDWmibxMkChOTrw0iLot8iD84fzklvlbt6wuQW+XB3Q+UO4QGjPyhmQc3/GkLPnpFjJqv+JD0ICwOdPBdr8DgLwyoKjBGGfB+1uFf/4KFX4PpU0IPU+aYhtLEGx/36jZkC6v4S7+G2coKv66eocteV9MbJEQ+ZVjmoWzaL8u/QZSffLbPspt8Xm2R5pKG3bGiczSftxz18M6oidYPi1c1unHMTxRFMCF4+7cGg9BPZ0Xo5eQepQ8zWhFpHBSajQcFoahQTsc14pq81NjBNPI5coRJcWinUp/TMZYlBBdv20j6C63eTVx51Mylp62v6V6tFTSHpBxVjcyqm3TdY5IgQIDAQAB"
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
    {
      name    = "@"
      proxied = false
      ttl     = 60
      type    = "TXT"
      value   = "qase-40db7bf7480a7e963d2cc6df9581286876de8705"
    },
    {
      name    = "dftsp._domainkey"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "v=DKIM1; k=rsa; h=sha256; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCpncN2uR1h3U9waNyIfsYWayMgVQs62wyMWoF/oQMxgTPpVxlK0LoI7qp4h2H97MI7NpJRPV2YbLADDv4fkKOvHKY5bQn4mTvSY1KUZzIhmnDw3C4emnyOKYNZhps70bGQxledBRfKGeqxT7qV53aoZ1ny/10Rj+LdXg7hmwg0uwIDAQAB"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "zoom-domain-verification=ZOOM_verify_43acaefd23ea473fa2bbb66524a9e72c"
    },
    // START MARKETO
    {
      name    = "m1._domainkey"
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "v=DKIM1;k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDR4uxprTLq7reHaYKtsmp987Q2qEI4aZGfIdYX+iDcwOh+m7rMMMux/wzb6rjqTzoayzaIWFTt5ttzCfTrUd0xTrmaB4D+jt4QQb1hSwbTKwR91jOdpWkZMxz3JptMJxwKHB6nYK1kGS88MvAZSOyg4hT7CfSavHoiss4crk4PYwIDAQAB"
    },
    {
      name    = "@"
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "google-site-verification=_jPHdbG8FcQmWJ0Vm_Y3AxmBp-aSHGGXA8hBlr8pKmw"
    },
    // END MARKETO
    {
      name    = "@"
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "cursor-domain-verification-s3qxz4=4RsFe21qzUjCfusM2aAJzryZD"
    },
    // START UNIVERSITY
    {
      name    = "_dmarc.em.sandbox.university"
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "v=DMARC1; p=quarantine; aspf=r; pct=100; rua=mailto:rua_38b6f6b37e6ff565@us.report.letsdmarc.com,mailto:re+wmjldel3qjv@dmarc.postmarkapp.com"
    },
    {
      name    = "_dmarc.university.jumpcloud.com."
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "v=DMARC1; p=quarantine; aspf=r; pct=100; rua=mailto:rua_38b6f6b37e6ff565@us.report.letsdmarc.com,mailto:re+wmjldel3qjv@dmarc.postmarkapp.com"
    },
    // END UNIVERSITY
    // START PARTNERJCU
    {
      name    = "_dmarc.partnerjcu.jumpcloud.com."
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "v=DMARC1; p=quarantine; aspf=r; pct=100; rua=mailto:rua_38b6f6b37e6ff565@us.report.letsdmarc.com,mailto:re+wmjldel3qjv@dmarc.postmarkapp.com"
    },
    // END PARTNERJCU
    {
      name    = "@"
      proxied = false
      ttl     = 3600
      type    = "TXT"
      value   = "v=MCPv1; k=ed25519; p=BhczxE2EljfcCMHGcIzTXKzpfaqz0wbmI4KTBaU42oo="
    },
    {
      name    = "tools"
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "replit-verify=51107684-3c09-4673-853b-234f2aa50f05"
    },
  ]

  # Empty after eu NS→R53 (#907). Remaining jcplatform/mulesoft labels already live in
  # Route53 eu.jumpcloud.com (weighted O2O). CF parent AA answers shadowed R53; destroy
  # these so recursion follows the eu NS. Companion: infra-edge create_cloudflare_cname=false.
  # Keep eu NS elsewhere; do not put brand CNAMEs back here.
  prd_eu_records = []
  prd_dns_records = concat(local.prd_a_records, local.prd_mx_records, local.prd_cname_records, local.prd_misc_records, local.prd_eu_records)

}

moved {
  from = module.dns.cloudflare_record.dns_records["info_706-RST-100.mktoweb.com"]
  to   = module.dns.cloudflare_record.dns_records["info_706-rst-100.mktoweb.com"]
}
