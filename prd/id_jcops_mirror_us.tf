# id.jumpcloud.com proxied rows → jcops.net (CH custom_origin_server targets).
#
# Brand id DNS lives in the id.jumpcloud.com child zone, so it is not covered by
# the jumpcloud.com → jcops.net mirror. Same pattern as stg01 #863 / vault mirror.
# CH hostnames stay brand FQDNs on jcops.net; origins are <label>.id.jcops.net.

locals {
  id_jumpcloud_jcops_mirror_records = [
    {
      name    = "admin-oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "admin_oauth_id.prd-use1.jcplatform.dev"
    },
    {
      name    = "oauth.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "oauth_id.prd-use1.jcplatform.dev"
    },
    {
      name    = "trampoline.id"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "trampoline_id.prd-use1.jcplatform.dev"
    },
  ]

  # CDN+CH warm path hosts that are not yet proxied on jumpcloud.com (so they
  # never enter jcops_mirrored_dns_records). Origins match infra-edge prd/data_cdn.tf.
  jcops_ch_origin_only_records = [
    {
      name    = "ai-aws"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "ai.prd-use1.jcplatform.dev"
    },
    {
      name    = "catalog"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "data-catalog.prd-use1.jcplatform.dev"
    },
    {
      name    = "password-manager"
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "password-manager.prd-use1.jcplatform.dev"
    },
  ]
}
