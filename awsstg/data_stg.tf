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
      name = "adbridge-kickstart"
      ttl = "null"
      type = "A"
      value = "awsstg-adbridge-kickstart-hap-80b532e17309fb71.elb.us-west-2.amazonaws.com."
    },
    {
      name = "adbridge"
      ttl = "null"
      type = "A"
      value = "awsstg-adbridge-haproxy-cd77d9c0d55c25b3.elb.us-west-2.amazonaws.com."
    },
    {
      name = "agent"
      ttl = "null"
      type = "A"
      value = "awsstg-agent-haproxy-eaefad6faf4f8e3d.elb.us-west-2.amazonaws.com."
    },
    {
      name = "api"
      ttl = "null"
      type = "A"
      value = "awsstg-api-haproxy-da4156afde33c7f1.elb.us-west-2.amazonaws.com."
    },
    {
      name = "assist"
      ttl = "null"
      type = "A"
      value = "awsstg-assist-haproxy-e45ad0d88c274312.elb.us-west-2.amazonaws.com."
    },
    {
      name = "awsstg-events-elasticsearch-usw2b-01"
      ttl = "300"
      type = "A"
      value = "10.20.1.127"
    },
    {
      name = "awsstg-events-elasticsearch-usw2b-02"
      ttl = "300"
      type = "A"
      value = "10.20.1.179"
    },
    {
      name = "awsstg-events-elasticsearch-usw2b-03"
      ttl = "300"
      type = "A"
      value = "10.20.1.104"
    },
    {
      name = "awsstg-mongo-datadb-usw2b-primary"
      ttl = "30"
      type = "A"
      value = "10.20.1.239"
    },
    {
      name = "awsstg-mongo-datadb-usw2b-secondary-01"
      ttl = "30"
      type = "A"
      value = "10.20.1.72"
    },
    {
      name = "awsstg-mongo-datadb-usw2b-secondary-02"
      ttl = "30"
      type = "A"
      value = "10.20.1.254"
    },
    {
      name = "bss"
      ttl = "null"
      type = "A"
      value = "awsstg-si-bss-api-haproxy-af17284e86128e27.elb.us-west-2.amazonaws.com."
    },
    {
      name = "console"
      ttl = "null"
      type = "A"
      value = "awsstg-console-haproxy-1b0a8f1489bf65fa.elb.us-west-2.amazonaws.com."
    },
    {
      name = "device-cert"
      ttl = "null"
      type = "A"
      value = "awsstg-device-cert-haproxy-97826775d48c4ee3.elb.us-west-2.amazonaws.com."
    },
    {
      name = "elastic"
      ttl = "null"
      type = "A"
      value = "awsstg-nlb-kibana-haproxy-eb196ccbe7191ba0.elb.us-west-2.amazonaws.com."
    },
    {
      name = "events"
      ttl = "300"
      type = "A"
      value = "10.20.1.55"
    },
    {
      name = "kickstart"
      ttl = "null"
      type = "A"
      value = "awsstg-kickstart-public-haproxy-87bd34e05ed3b9ab.elb.us-west-2.amazonaws.com."
    },
    {
      name = "usw1.ldap-mfa"
      ttl = "null"
      type = "A"
      value = "awsstg-ldap-mfa-haproxy-fc7b281b227f88a0.elb.us-west-1.amazonaws.com."
    },
    {
      name = "usw2.ldap-mfa"
      ttl = "null"
      type = "A"
      value = "awsstg-ldap-mfa-haproxy-a0e67a2d5f7390ae.elb.us-west-2.amazonaws.com."
    },
    {
      name = "ldap"
      ttl = "null"
      type = "A"
      value = "usw1.ldap.awsstg.jumpcloud.com."
    },
    {
      name = "ldap"
      ttl = "null"
      type = "A"
      value = "usw2.ldap.awsstg.jumpcloud.com."
    },
    {
      name = "usw1.ldap"
      ttl = "null"
      type = "A"
      value = "awsstg-openldap-haproxy-cd9e132d98681e53.elb.us-west-1.amazonaws.com."
    },
    {
      name = "usw2.ldap"
      ttl = "null"
      type = "A"
      value = "awsstg-openldap-haproxy-b8a9eb2905a0484d.elb.us-west-2.amazonaws.com."
    },
    {
      name = "apple.mdm"
      ttl = "null"
      type = "A"
      value = "awsstg-apple-mdm-haproxy-ada1cbff4b84e7d2.elb.us-west-2.amazonaws.com."
    },
    {
      name = "private-kickstart"
      ttl = "null"
      type = "A"
      value = "awsstg-kickstart-priv-haproxy-25cca193df1762ea.elb.us-west-2.amazonaws.com."
    },
    {
      name = "radius"
      ttl = "300"
      type = "A"
      value = "13.57.87.164"
    },
    {
      name = "radius"
      ttl = "300"
      type = "A"
      value = "52.89.214.200"
    },
    {
      name = "us1.radius"
      ttl = "300"
      type = "A"
      value = "52.89.214.200"
    },
    {
      name = "us2.radius"
      ttl = "300"
      type = "A"
      value = "13.57.87.164"
    },
    {
      name = "sentry"
      ttl = "null"
      type = "A"
      value = "dualstack.internal-awsstg-sentry-1598789881.us-west-2.elb.amazonaws.com."
    },
    {
      name = "sso"
      ttl = "null"
      type = "A"
      value = "awsstg-sso-haproxy-1c5c07d1c09a69bd.elb.us-west-2.amazonaws.com."
    },
    {
      name = "delegated-auth.us-west-2"
      ttl = "null"
      type = "A"
      value = "internal-awsstg-us-west-2-auth-lambda-791991147.us-west-2.elb.amazonaws.com."
    }
  ]

  stg_mx_records = [
  ]

  stg_cname_records = [
    {
      name = "assets"
      ttl = "300"
      type = "CNAME"
      value = "d193ib4v2852zx.cloudfront.net"
    },
    {
      name = "_35077d2d975b04cc14a4666712e06846.assets"
      ttl = "60"
      type = "CNAME"
      value = "_1733e553fa78674dac3d1c6b3b7fc826.nhqijqilxf.acm-validations.aws."
    },
    {
      name = "cdn"
      ttl = "300"
      type = "CNAME"
      value = "d2008dpdnzrhly.cloudfront.net"
    },
    {
      name = "_df0cfd5c0b60d4f1f50c62b29f705964.cdn"
      ttl = "60"
      type = "CNAME"
      value = "_709803936126501b060c1cc0900bd01e.nhsllhhtvj.acm-validations.aws."
    },
    {
      name = "_e76c0c4507ca0ec38fed8a613af07534.demo"
      ttl = "300"
      type = "CNAME"
      value = "_a180c18c380e2b126b7428529cb9631a.olprtlswtu.acm-validations.aws."
    },
    {
      name = "ldap-mfa"
      ttl = "60"
      type = "CNAME"
      value = "usw1.ldap-mfa.awsstg.jumpcloud.com"
    },
    {
      name = "ldap-mfa"
      ttl = "60"
      type = "CNAME"
      value = "usw2.ldap-mfa.awsstg.jumpcloud.com"
    },
    {
      name = "_0921a601a8d7472ed2fc08c2ec3c0229.delegated-auth.us-west-2"
      ttl = "60"
      type = "CNAME"
      value = "_442fe84fd4a8e2bb5c930e4cc9a1b039.vrztfgqhxj.acm-validations.aws."
    },
    {
      name = "web-a"
      ttl = "null"
      type = "CNAME"
      value = "web.awsstg.jumpcloud.com."
    },
    {
      name = "web"
      ttl = "300"
      type = "CNAME"
      value = "j.sni.global.fastly.net"
    }
  ]

  stg_misc_records = [
    {
      name = "awsstg.jumpcloud.com."
      ttl = "300"
      type = "TXT"
      value = "google-site-verification=fUOm_FpYJ2K5rcOwrAUxvJRIjl5klKUl11FdvUx-yRw"
    }
  ]

  // Stg records get a special treatment to format the name to include the awsstg prefix
  // TODO: In the future when there are misc records, they probably should not get this treatment (only a and cname records)
  stg_dns_records = [
    for entry in concat(local.stg_a_records, local.stg_cname_records, local.stg_misc_records) : {
      name = format("%s.awsstg", entry.name)
      value = entry.value
      type = entry.type
      ttl = entry.ttl
      proxied = entry.proxied
    }
  ]
}
