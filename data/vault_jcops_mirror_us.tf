# Proxied vault.jumpcloud.com source rows for jcops.net mirror (TE-2005).
# Production hostnames only — dev/stg/homolog live in the same CF zone.
# Keep in sync with prd/data_additional.tf local.vault_records (proxied = true).
# Run: python3 scripts/check_vault_jcops_mirror_parity.py

locals {
  vault_jumpcloud_child_zone = "vault.jumpcloud.com"

  vault_jumpcloud_proxied_source_records = [
    {
      name    = "*.app.vault.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "*.api.vault.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "app.vault.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "api.vault.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "*.ws.vault.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "ws.vault.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "vault.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "d1iz1fyeo9jhbg.cloudfront.net"
    },
    {
      name    = "*.vault.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "d1iz1fyeo9jhbg.cloudfront.net"
    },
  ]
}
