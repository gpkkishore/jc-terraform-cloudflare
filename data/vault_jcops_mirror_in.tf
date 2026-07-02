# Proxied vault.in source rows for in.jcops.net mirror (TE-2005).
# Keep in sync with prd/data_additional.tf local.vault_in_records (proxied = true).
# Run: python3 scripts/check_vault_jcops_mirror_parity.py

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
