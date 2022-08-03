# AWSSTG Records

resource "cloudflare_record" "awsstg_dns_records" {
  for_each = var.enable_awsstg == true ? { for record in var.awsstg_dns_records : record.name => record } : {}
  name     = format("%s.awsstg", each.value.name)
  value    = each.value.value
  ttl      = each.value.ttl
  type     = each.value.type
  proxied  = each.value.proxied
  zone_id  = var.zone_id
}

# NonPRD Records
module "non_prd_dns" {
  count   = var.enable_nonprod == true ? 1 : 0
  source  = "./nonprod"
  zone_id = var.zone_id
}

# PRD Records

resource "cloudflare_record" "prd_dns_records" {
  for_each = { for record in var.prd_dns_records : record.name => record }
  name     = each.value.name
  value    = each.value.value
  ttl      = each.value.ttl
  type     = each.value.type
  proxied  = each.value.proxied
  zone_id  = var.zone_id
}

resource "cloudflare_record" "marketing_website" {
  name    = "@"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "23.185.0.1"
  zone_id = var.zone_id
}

resource "cloudflare_record" "www_marketing_website" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "23.185.0.1"
  zone_id = var.zone_id
}

resource "cloudflare_record" "www_aaaa_marketing_website_1" {
  name    = "www"
  value   = "2620:12a:8001::1"
  type    = "AAAA"
  ttl     = "1"
  proxied = true
  zone_id = var.zone_id
}

resource "cloudflare_record" "www_aaaa_marketing_website_2" {
  name    = "www"
  value   = "2620:12a:8000::1"
  type    = "AAAA"
  ttl     = "1"
  proxied = true
  zone_id = var.zone_id
}

# Original MX records from jumpcloud.com
resource "cloudflare_record" "terraform_managed_resource_b768e60dc1d41bb15d089ccb1db859e0" {
  name     = "@"
  priority = 20
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx3.googlemail.com" #"20 ASPMX3.GOOGLEMAIL.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_c5bce7b1ac03f4eccafa9955e47c0d60" {
  name     = "@"
  priority = 15
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx2.googlemail.com" #"15 ASPMX2.GOOGLEMAIL.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_d7693e2bb7f516ade6bba363b7152e1a" {
  name     = "@"
  priority = 10
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt2.aspmx.l.google.com" #"10 ALT2.ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_cb8166958ff9523ef5ec730250808304" {
  name     = "@"
  priority = 5
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt1.aspmx.l.google.com" #"5 ALT1.ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_b8243683bc1e47302a9ac3693ecfe41a" {
  name     = "@"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx.l.google.com" # "1 ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

#Original MX records from jumpcloud.com
resource "cloudflare_record" "terraform_managed_resource_c8243683bc1e47302a9ac3693ecfe41a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx3.googlemail.com" # "10 ASPMX3.GOOGLEMAIL.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_d8243683bc1e47302a8ac3693ecfe41a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt2.aspmx.l.google.com" #"5 ALT2.ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_18243683bc1e47302a8ac3693ecf453a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx.l.google.com" #"1 ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_23244673bc1e47302a8ac3693ecf453a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx2.googlemail.com" #"10 ASPMX2.GOOGLEMAIL.COM"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_232423433bc1e47302a8ac387ecf453a" {
  name     = "get"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt1.aspmx.l.google.com" #"5 ALT1.ASPMX.L.GOOGLE.COM"
  zone_id  = var.zone_id
}

# Original SOA records from jumpcloud.com

/*resource "cloudflare_record" "terraform_managed_resource_ed3s3683bc1e47302a9ac3693ecfe41a" {
  name     = "@"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "SOA"
  value    = "ns-1687.awsdns-18.co.uk. awsdns-hostmaster.amazon.com. 9 7200 900 1209600 86400"
  zone_id  = var.zone_id
}*/

# Original NS records from production.jumpcloud.com
/*resource "cloudflare_record" "terraform_managed_resource_196b1c537db0885f8ab54f3619d2f8b1" {
  name    = "production"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-512.awsdns-00.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_e5fcc59da5b3577e9869cf976ebe0877" {
  name    = "production"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-1024.awsdns-00.org"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f5cd841f35f3196d3f722b15fe90239f" {
  name    = "production"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-0.awsdns-00.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f4de492c3a3b1877d98d68fa8c118fa2" {
  name    = "production"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-1536.awsdns-00.co.uk"
  zone_id = var.zone_id
}*/

/*
resource "cloudflare_record" "terraform_managed_resource_b1115f3910db3230cd9fc5a17ddcdb6d" {
  name    = "awsstg"
  proxied = false
  ttl     = 86400
  type    = "NS"
  value   = "ns-1192.awsdns-21.org"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_adb9c6a7aa7a5b4ede8580207cc2add6" {
  name    = "awsstg"
  proxied = false
  ttl     = 86400
  type    = "NS"
  value   = "ns-1689.awsdns-19.co.uk"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_4a3bd21c04ae1d0cf362d5c39ff32e27" {
  name    = "awsstg"
  proxied = false
  ttl     = 86400
  type    = "NS"
  value   = "ns-811.awsdns-37.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_ed61c1709913db8488e0684b2e2675ff" {
  name    = "awsstg"
  proxied = false
  ttl     = 86400
  type    = "NS"
  value   = "ns-241.awsdns-30.com"
  zone_id = var.zone_id
}
*/

# Original AAAA records
resource "cloudflare_record" "terraform_managed_resource_9bb19a7d138fd2f365a0035c42f872ce" {
  name    = "@"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8001::1"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_d452c31cc5f76e72f78e4faf2da71199" {
  name    = "@"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8000::1"
  zone_id = var.zone_id
}

#AWSSTG ns for subdomain delegation
resource "cloudflare_record" "awsstg_aws_ns" {
  for_each = toset(var.awsstg_aws_ns)
  zone_id  = var.zone_id
  name     = "awsstg"
  value    = each.value
  type     = "NS"
  ttl      = 300
}

#sec ns for subdomain delegation
resource "cloudflare_record" "sec_aws_ns" {
  for_each = toset(var.sec_aws_ns)
  zone_id  = var.zone_id
  name     = "sec"
  value    = each.value
  type     = "NS"
  ttl      = 300
}
