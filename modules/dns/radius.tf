#radius ns for subdomain delegation
resource "cloudflare_record" "radius_aws_ns" {
  for_each = toset(var.radius_aws_ns)
  zone_id  = var.zone_id
  name     = "radius"
  value    = each.value
  type     = "NS"
  ttl      = 300
}