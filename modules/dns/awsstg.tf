// Simple dns records from awsstg.jumpcloud.com

resource "cloudflare_record" "terraform_managed_resource_34bc781abebe2c4f61c65a134438934b" {
  name    = "awsstg-events-elasticsearch-usw2b-01.awsstg.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "A"
  value   = "10.20.1.127"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_233afd45cabab799826fdefaf7e12f52" {
  name    = "awsstg-events-elasticsearch-usw2b-02.awsstg.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "A"
  value   = "10.20.1.179"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_caf4930eed11c23c1d4f673863e40ff9" {
  name    = "awsstg-events-elasticsearch-usw2b-03.awsstg.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "A"
  value   = "10.20.1.104"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_7a2a7d773d3566c829b1f24d4a914bc7" {
  name    = "awsstg-mongo-datadb-usw2b-primary.awsstg.jumpcloud.com"
  proxied = false
  ttl     = 30
  type    = "A"
  value   = "10.20.1.239"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_380550dbc668d5ad0d514a5d70a12421" {
  name    = "awsstg-mongo-datadb-usw2b-secondary-01.awsstg.jumpcloud.com"
  proxied = false
  ttl     = 30
  type    = "A"
  value   = "10.20.1.72"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_ed06e20db6ebffceef0a4deb9784dd5b" {
  name    = "awsstg-mongo-datadb-usw2b-secondary-02.awsstg.jumpcloud.com"
  proxied = false
  ttl     = 30
  type    = "A"
  value   = "10.20.1.254"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_ca9f016ec7308a62e1ed2e1cff1e2ab5" {
  name    = "events.awsstg.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "A"
  value   = "10.20.1.55"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_bb7cafcdc321482ad58bf3e887fdf0c8" {
  name    = "ldap.awsstg.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "A"
  value   = "10.20.1.193"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_12beec248f8bd861d2c9dd36fad65df0" {
  name    = "ldap.awsstg.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "A"
  value   = "10.20.33.198"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_11936c73ddfce0ed8e95023d67df327c" {
  name    = "radius.awsstg.jumpcloud.com"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "52.89.214.200"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_7ae2242bf7070064c15006864899db2b" {
  name    = "radius.awsstg.jumpcloud.com"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "13.57.87.164"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_7317e0913f06657c219c340495bd5d1a" {
  name    = "us1.radius.awsstg.jumpcloud.com"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "52.89.214.200"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_3dc2971e5d233e01b5b16871db65a7fb" {
  name    = "us2.radius.awsstg.jumpcloud.com"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "13.57.87.164"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_1b4b3f41d86986cb56bc2d7e6aaefbba" {
  name    = "_35077d2d975b04cc14a4666712e06846.assets.awsstg.jumpcloud.com"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "_1733e553fa78674dac3d1c6b3b7fc826.nhqijqilxf.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_49e9bdf0e35a6bc3c0b517df870eebf8" {
  name    = "assets.awsstg.jumpcloud.com"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "d193ib4v2852zx.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f312c594999a047705e2a06a84501198" {
  name    = "_e76c0c4507ca0ec38fed8a613af07534.demo.awsstg.jumpcloud.com"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "_a180c18c380e2b126b7428529cb9631a.olprtlswtu.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_be2cd3e74b377b5b54648daa294dd1a3" {
  name    = "web.awsstg.jumpcloud.com"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "j.sni.global.fastly.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_608bc6ffdcb06e692954b600db1f4d82" {
  name    = "awsstg.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "google-site-verification=fUOm_FpYJ2K5rcOwrAUxvJRIjl5klKUl11FdvUx-yRw"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}