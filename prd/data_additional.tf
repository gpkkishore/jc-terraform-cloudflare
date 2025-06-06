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
    "stackidentity.com",
    "vault.jumpcloud.com",
  ], local.resmo_zones[*].name)

  ###########################################
  # Vault
  ###########################################  
  vault_records = [

  ]

  ###########################################
  # Zercurity
  ###########################################  
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

  ###########################################
  # jumpcloud.ai
  ###########################################
  jumpcloud_ai_tmp_records = [
    {
      name    = "jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli.prd-use1.jcplatform.dev"
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

  ###########################################
  # StackIdentity
  ###########################################
  stackidentity_tmp_records = [
    {
      name    = "@",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "54.197.63.83"
    },
    {
      name    = "@",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "google-site-verification=GigGMaov2xNgLKVnXry-PwoP9ULiWW57vpfXg5E8Ejk"
    },
    // TXT
    {
      name    = "@",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "v=spf1  include:_spf.google.com include:spf.protection.outlook.com include:zcsend.net ~all"
    },
    {
      name    = "201034._domainkey",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDkDYZCSfJZ9pw/sATNp6QoLdcOjF0hErKiepqDgVFFRjBA12VelBbLNF7byoyWDkmF5SIPONHfI4CfWo9UGgMEfR8fUrPYvWk+3FyfJSkNx3JJDGJxg4SEm4TyB6NUokwExpbS1yeV4TRaa17GJaszNpvsJAa7qRHqyuOMLZHs1wIDAQAB"
    },
    {
      name    = "google._domainkey",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgGAA06VV/1sfK2TOTiy7gUHNadKiB+R5fexn059zij8BhXASdb6t2Pb0N5ssjjbypAhCULIE/l5NRfXF77MeQyxC/hV9iY7iSsG9DpAQ63DO575iMIKT0Yj6gs+ViAaPqZTZJRbsWhYErIDwcOEr87gb7eiA/emlCHn+tSunN3KIGuZopcug578vdZFcdyd4nyTFoDGzsLiAcTwhmlaof8UqeIvpWn6DhKO2tsWaDHkVYQNswrK90C4lAbLwggLLY4o+se8i3YjApr5ELaj5dEQMZwYq0Gs/20YrYjNxqtkR6RscEPJHxRGY2iTweQa78ABVhRab4GUYjk+NlmQeCQIDAQAB"
    },
    {
      name    = "_acme-challenge",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "i8ZT1YqybQEpFqJKDXZYgPnU8YbLQNazmNdt4anNxiw"
    },
    {
      name    = "_amazonses",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "FaEEbJq2BA2G2dwbUKzxtGsMGcorLtcTYGEIOCUU+bw="
    },
    {
      name    = "_dmarc",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "v=DMARC1; p=none; rua=mailto:postmaster@stackidentity.com; adkim=s; aspf=s"
    },    
    {
      name    = "_gh-stackid-e",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "a26e27f720"
    },    
    // CNAME
    {
      name    = "autodiscover"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "autodiscover.outlook.com."
    },
    {
      name    = "enterpriseenrollment"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "enterpriseenrollment.manage.microsoft.com."
    },
    {
      name    = "enterpriseregistration"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "enterpriseregistration.windows.net."
    },
    {
      name    = "hs3zgaufq3ce7hho4rpi56uesnmaaafo._domainkey"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "hs3zgaufq3ce7hho4rpi56uesnmaaafo.dkim.amazonses.com."
    },
    {
      name    = "htskszr2d6fr5nzb4dgoyiwwctxa6wj5._domainkey"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "htskszr2d6fr5nzb4dgoyiwwctxa6wj5.dkim.amazonses.com."
    },    
    {
      name    = "xfxd6vlc6fqsfejgvtppnwe27n3qubw._domainkey"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "jxfxd6vlc6fqsfejgvtppnwe27n3qubw.dkim.amazonses.com."
    },
    {
      name    = "lyncdiscover"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "webdir.online.lync.com."
    },
    {
      name    = "sip"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "sipdir.online.lync.com."
    },
    {
      name    = "www"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "stackidentity.com"
    },
    {
      name    = "_domainconnect"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "_domainconnect.gd.domaincontrol.com."
    },
    // MX
    {
      name     = "@"
      priority = 1
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "aspmx.l.google.com."
    },
    {
      name     = "@"
      priority = 10
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "alt4.aspmx.l.google.com."
    },
    {
      name     = "@"
      priority = 10
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "alt3.aspmx.l.google.com."
    },
    {
      name     = "@"
      priority = 5
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "alt1.aspmx.l.google.com."
    },
    {
      name     = "@"
      priority = 5
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "alt2.aspmx.l.google.com."
    },
  ]

  ###########################################
  # Resmo
  ###########################################
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

}
