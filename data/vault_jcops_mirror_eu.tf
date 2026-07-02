# Proxied vault.eu source rows for eu.jcops.net mirror (TE-2005).
# Keep in sync with prd/data_additional.tf local.vault_eu_records (proxied = true).
# Run: python3 scripts/check_vault_jcops_mirror_parity.py

locals {
  vault_eu_child_zone = "vault.eu.jumpcloud.com"

  vault_eu_proxied_source_records = [
    {
      name    = "*.app.vault.eu.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "*.api.vault.eu.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "app.vault.eu.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "api.vault.eu.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "*.ws.vault.eu.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "ws.vault.eu.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "@"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "d1l0uz48ej0js9.cloudfront.net"
    },
    {
      name    = "*.vault.eu.jumpcloud.com"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      content = "d1l0uz48ej0js9.cloudfront.net"
    },
  ]
}
