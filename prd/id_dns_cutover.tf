####################################################
# id.jumpcloud.com ingress cutover (orphaned external-dns → IaC)
#
# Live admin-oauth / oauth / trampoline CNAMEs were created by
# external-dns-cloudflare (now disabled) and never ported to TF.
# Adopt them here and flip orange → LB into grey → *.id.jcops.net
# (stg01 mcpv2 pattern). Router origins stay in id_jcops_mirror_us.tf.
#
# Pre-cutover values (revert checklist — proxied = true):
#   admin-oauth  → admin_oauth_id.prd-use1.jcplatform.dev
#   oauth        → oauth_id.prd-use1.jcplatform.dev
#   trampoline   → trampoline_id.prd-use1.jcplatform.dev
####################################################

locals {
  id_jumpcloud_brand_cutover_records = [
    {
      # was: proxied = true, value = "admin_oauth_id.prd-use1.jcplatform.dev"
      name    = "admin-oauth"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "admin-oauth.id.jcops.net"
    },
    {
      # was: proxied = true, value = "oauth_id.prd-use1.jcplatform.dev"
      name    = "oauth"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "oauth.id.jcops.net"
    },
    {
      # was: proxied = true, value = "trampoline_id.prd-use1.jcplatform.dev"
      name    = "trampoline"
      proxied = false
      ttl     = 1
      type    = "CNAME"
      value   = "trampoline.id.jcops.net"
    },
  ]

  id_jumpcloud_brand_cutover_by_name = {
    for r in local.id_jumpcloud_brand_cutover_records : r.name => r
  }
}

# Look up orphaned live records for import (still orange → jcplatform.dev today).
data "cloudflare_record" "id_jumpcloud_brand_cutover" {
  for_each = local.id_jumpcloud_brand_cutover_by_name

  zone_id  = cloudflare_zone.additional_zone["id.jumpcloud.com"].id
  hostname = "${each.key}.id.jumpcloud.com"
  type     = "CNAME"
}

import {
  for_each = local.id_jumpcloud_brand_cutover_by_name

  to = cloudflare_record.id_jumpcloud_brand_cutover[each.key]
  id = "${cloudflare_zone.additional_zone["id.jumpcloud.com"].id}/${data.cloudflare_record.id_jumpcloud_brand_cutover[each.key].id}"
}

resource "cloudflare_record" "id_jumpcloud_brand_cutover" {
  for_each = local.id_jumpcloud_brand_cutover_by_name

  zone_id = cloudflare_zone.additional_zone["id.jumpcloud.com"].id
  name    = each.value.name
  type    = each.value.type
  value   = each.value.value
  ttl     = each.value.ttl
  proxied = each.value.proxied
}
