resource "cloudflare_record" "terraform_managed_resource_fafd89e1b989f6f5447d44a83205c37d" {
  count   = var.enable_awsstg == true ? 1 : 0
  name    = "delfingen-ldap"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "34.204.118.37"
  zone_id = var.zone_id
}

#ldap ns for subdomain delegation
resource "cloudflare_record" "ldap_aws_ns" {
  count   = var.enable_awsstg == true ? 1 : 0
  for_each = toset(var.ldap_aws_ns)
  zone_id  = var.zone_id
  name     = "ldap"
  value    = each.value
  type     = "NS"
  ttl      = 300
}


# DNS records for the new ldap.jumpcloud.com subdomain in Route 53
/*
resource "cloudflare_record" "terraform_managed_resource_2f4cc444493304fcbcc3d3a57cd4dde5" {
  name    = "ldap"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "asia.ldap.jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_2f4cc444493304fcbcc3d3a57cd4dde5c" {
  name    = "ldap"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "eu.ldap.jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_2f4cc444493304fcbcc3d3a57cd4dde5d" {
  name    = "ldap"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "aws-us.ldap.jumpcloud.com"
  zone_id = var.zone_id
}
*/