# Proxied vault.in rows mirrored into in.jcops.net (TE-2005).
# Brand-zone vault api/app/ws orange CNAMEs moved to infra-edge; this list remains
# the source of truth for jcops router mirrors (including apex SPA).
# Run: python3 scripts/check_vault_jcops_mirror_parity.py
# (IN api/app/ws may be mirror-only vs prd/data_additional.tf after brand retire).

locals {
  vault_in_child_zone = "vault.in.jumpcloud.com"

  vault_in_proxied_source_records = [
    {
      name    = "*.app.vault.in.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "*.api.vault.in.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "app.vault.in.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "api.vault.in.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "*.ws.vault.in.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "ws.vault.in.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "@"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "d2notaopjayrxl.cloudfront.net"
    },
    {
      name    = "*.vault.in.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "d2notaopjayrxl.cloudfront.net"
    },
  ]
}
