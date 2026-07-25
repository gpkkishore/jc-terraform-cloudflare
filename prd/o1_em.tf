####################################################
# o1.em.jumpcloud.com — SendGrid / Pardot event webhook A
#
# Was live on Cloudflare outside Terraform. Adopt with
# allow_overwrite (module.dns has no per-record overwrite).
# Route 53 twin: infra-edge route53_brand_a_records.
####################################################

resource "cloudflare_record" "o1_em" {
  zone_id         = cloudflare_zone.cloudflare_zone_resource.id
  name            = "o1.em"
  type            = "A"
  value           = "198.21.2.137"
  ttl             = 1
  proxied         = false
  allow_overwrite = true
}
