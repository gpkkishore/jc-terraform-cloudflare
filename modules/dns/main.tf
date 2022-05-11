# Original jumpcloud.com A Records

resource "cloudflare_record" "events-internal-writes" {
    name = "events-internal-writes"
    proxied = false
    ttl = 1
    type = "CNAME"
    value = "dualstack.internal-prd-event-internal-writes-998198845.us-east-1.elb.amazonaws.com"
    zone_id = var.zone_id
}

resource "cloudflare_record" "marketing_website" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "23.185.0.1"
  zone_id = var.zone_id
}

resource "cloudflare_record" "www" {
  name    = "www"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "logging-rmq-admin-panel" {
  name = "logging-rmq-admin-panel"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "dualstack.prd-logging-rmq-admin-panel-500485683.us-east-1.elb.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "logging-rmq-use1b" {
  name = "logging-rmq-use1b"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "10.31.1.25"
  zone_id = var.zone_id
}

# What is this a management inferface for?
resource "cloudflare_record" "terraform_managed_resource_066e155f08e8eb05ce73e42687d425db" {
  name    = "mgmt"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.235.213.34"
  zone_id = var.zone_id
}

# Is this RabbitMQ???
resource "cloudflare_record" "terraform_managed_resource_184ca453ac6b691e1cb640b5c81d59ca" {
  name    = "prd-jumpcloud-logging-rmq-use1c-02"
  proxied = false
  ttl     = 60
  type    = "A"
  value   = "10.30.3.24"
  zone_id = var.zone_id
}

# Are these the HAProxy boxes?
resource "cloudflare_record" "terraform_managed_resource_d007e34993baf7d5e0fae95320e01674" {
  name    = "radius-proxy-1"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "104.197.52.17"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_59045fc6dee170a234942eb504e2d5a9" {
  name    = "radius-proxy-2"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "130.211.179.88"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_e2190ff1e1c5b0b3cbb4aee94849b637" {
  name    = "radius-proxy-3"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "130.211.141.152"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f390ac979105f232b937c3c2b736d77f" {
  name    = "radius-proxy-4"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "130.211.178.171"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_18f7188113420fbc8a634c828551a7c0" {
  name    = "remote"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "3.90.90.234"
  zone_id = var.zone_id
}

# Original Geolocation A Records
resource "cloudflare_record" "adbridge-kickstart" {
  name = "adbridge-kickstart"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-adbridge-kickstart-hap-15cdca89ba728b61.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "adbridge" {
  name = "adbridge"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-adbridge-haproxy-95a0127e2a51ca9c.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "agent" {
  name = "agent"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-agent-haproxy-b20d9869679d351a.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "api" {
  name = "api"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-api-haproxy-26b2f6dff2b6c74e.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "apple-mdm" {
  name = "apple-mdm"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-apple-mdm-haproxy-d05a7a9d47266a34.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "bss" {
  name = "bss"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-si-bss-api-haproxy-6e046266a51cbefa.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "console" {
  name = "console"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-console-haproxy-7e5666187f103747.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "device-cert" {
  name = "device-cert"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-device-cert-haproxy-4d41711b05fd478e.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "elastic" {
  name = "elastic"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-nlb-kibana-haproxy-e27a67d6237121da.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "kickstart" {
  name = "kickstart"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-kickstart-public-haproxy-a6276758df0978b6.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "asia_ldap" {
  name = "asia.ldap"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-openldap-haproxy-97006fce924c2aa2.elb.ap-northeast-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "aws-us_ldap" {
  name = "aws-us.ldap"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-openldap-haproxy-b6684a1c843e9d58.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "eu_ldap" {
  name = "eu.ldap"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-openldap-haproxy-5e177b641df725c8.elb.eu-central-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "apple_mdm" {
  name = "apple.mdm"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-apple-mdm-haproxy-d05a7a9d47266a34.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "private-kickstart" {
  name = "private-kickstart"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-kickstart-priv-haproxy-51a0179c97e2d9d8.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "sso" {
  name = "sso"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "prd-sso-haproxy-f6664e7167075b59.elb.us-east-1.amazonaws.com"
  zone_id = var.zone_id
}

# Original MX records from jumpcloud.com
resource "cloudflare_record" "terraform_managed_resource_b768e60dc1d41bb15d089ccb1db859e0" {
  name     = "jumpcloud.com"
  priority = 20
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx3.googlemail.com"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_c5bce7b1ac03f4eccafa9955e47c0d60" {
  name     = "jumpcloud.com"
  priority = 15
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx2.googlemail.com"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_d7693e2bb7f516ade6bba363b7152e1a" {
  name     = "jumpcloud.com"
  priority = 10
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt2.aspmx.l.google.com"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_cb8166958ff9523ef5ec730250808304" {
  name     = "jumpcloud.com"
  priority = 5
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt1.aspmx.l.google.com"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_b8243683bc1e47302a9ac3693ecfe41a" {
  name     = "jumpcloud.com"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx.l.google.com"
  zone_id  = var.zone_id
}

# Original NS records from jumpcloud.com
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
resource "cloudflare_record" "terraform_managed_resource_196b1c537db0885f8ab54f3619d2f8b1" {
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
}

resource "cloudflare_record" "terraform_managed_resource_ade89019080bb4b31eb53b0ad287f81a" {
  name    = "radius"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-1931.awsdns-49.co.uk"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_a3fbf4d5324ba12ea6a97b11b7b2487c" {
  name    = "radius"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-1434.awsdns-51.org"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_e54d194dbaeec3292cd2eb7614a19027" {
  name    = "radius"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-465.awsdns-58.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f1843f5f077219f4888a3334c9b6c54c" {
  name    = "radius"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-585.awsdns-09.net"
  zone_id = var.zone_id
}

# Original AAAA records
resource "cloudflare_record" "terraform_managed_resource_9bb19a7d138fd2f365a0035c42f872ce" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8001::1"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_d452c31cc5f76e72f78e4faf2da71199" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8000::1"
  zone_id = var.zone_id
}