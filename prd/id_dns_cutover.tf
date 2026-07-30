####################################################
# id.jumpcloud.com ingress cutover — retired to infra-edge #205.
#
# Live admin-oauth / oauth / trampoline grey→*.id.jcops.net were adopted here
# from external-dns. Ownership moves to infra-edge module.cdn (migrate_cname).
#
# Spacelift state-rm on prd-cloudflare before apply (leaves live DNS):
#   cloudflare_record.id_jumpcloud_brand_cutover["admin-oauth"]
#   cloudflare_record.id_jumpcloud_brand_cutover["oauth"]
#   cloudflare_record.id_jumpcloud_brand_cutover["trampoline"]
#
# Router origins stay in id_jcops_mirror_us.tf.
####################################################

locals {
  id_jumpcloud_brand_cutover_records = []

  id_jumpcloud_brand_cutover_by_name = {
    for r in local.id_jumpcloud_brand_cutover_records : r.name => r
  }
}

resource "cloudflare_record" "id_jumpcloud_brand_cutover" {
  for_each = local.id_jumpcloud_brand_cutover_by_name

  zone_id         = cloudflare_zone.additional_zone["id.jumpcloud.com"].id
  name            = each.value.name
  type            = each.value.type
  value           = each.value.value
  ttl             = each.value.ttl
  proxied         = each.value.proxied
  allow_overwrite = true
}
