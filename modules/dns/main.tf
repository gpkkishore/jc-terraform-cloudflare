# Original jumpcloud.com A Records

resource "cloudflare_record" "events-internal-writes" {
  name = "events-internal-writes"
  proxied = false
  ttl = 1
  type = "CNAME"
  value = "dualstack.internal-prd-event-internal-writes-998198845.us-east-1.elb.amazonaws.com"
  zone_id = var.zone_id
}
