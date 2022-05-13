resource "cloudflare_record" "terraform_managed_resource_5f436ab20a0aa3376823dd43bd149ce4" {
  name    = "awsstg-vpn"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "34.214.221.231"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_20be7eae4a23e65e4d9db0e322fab64d" {
  name    = "devopsdays"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "192.155.251.138"
  zone_id = var.zone_id
}

resource "cloudflare_record" "devvpn" {
  name    = "devvpn"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "mgmt.jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "do-1241-test" {
  name    = "do-1241-test"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "s3-website.us-east-2.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_68f8090abf2e83b932a06ba20edcb76f" {
  name    = "kanban"
  proxied = false
  ttl     = 300
  type    = "A"
  value   = "10.240.0.53"
  zone_id = var.zone_id
}

# Are these supposed to be NAT boxes?
resource "cloudflare_record" "terraform_managed_resource_8090221c6d5fed3e1061bbfd51edbf93" {
  name    = "nat1b"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.86.131.111"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_506256035f6f51779936219d52d49799" {
  name    = "nat1c"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.86.134.208"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_acfce0cbe9f80ff8c9ca89b934d784b1" {
  name    = "nat1d"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.86.96.53"
  zone_id = var.zone_id
}

# ???
resource "cloudflare_record" "terraform_managed_resource_24a0bb2e2309ea82a8ea65b23e87b2fa" {
  name    = "o1.em"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "198.21.2.137"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_873149644be01908b3b0fdd77e91bf12" {
  name    = "o2.ptr1370.test"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "168.245.76.83"
  zone_id = var.zone_id
}

resource "cloudflare_record" "staging-agent" {
  name    = "staging-agent"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "staging.jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "staging-kickstart" {
  name    = "staging-kickstart"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "staging.jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_5d06d0acc6f9abbb36f2a6034f01a478" {
  name    = "staging-radius-proxy"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "130.211.178.124"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_21947a021697e4c65ea91317b9bbde93" {
  name    = "staging-vpn"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "104.196.2.104"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_915c7212287f0cfc2ea26b0d1093ea67" {
  name    = "staging"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.225.98.126"
  zone_id = var.zone_id
}

resource "cloudflare_record" "sysvpn" {
  name    = "sysvpn"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "mgmt.jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "test-agent" {
  name    = "test-agent"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "test.jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "test-console" {
  name    = "test-console"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "test.jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "test-kickstart" {
  name    = "test-kickstart"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "test.jumpcloud.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_17bb370277f9302263200c7bf04d770f" {
  name    = "test-vpn"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "52.40.206.145"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_2f9d433d0f1d4a1c80a48bbfaa782b60" {
  name    = "test"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.235.82.193"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_5789efcdaf41097073a9b6ee861d38d8" {
  name    = "ti"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.2.132"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_1a3a74927c5538d7f2b3bf8c91c7e5b1" {
  name    = "ti"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.66.132"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f3ee1b1580af6f658e90784d66745b1d" {
  name    = "ti"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.130.132"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f3ee1b1580af6f658e90784d66745b1dc" {
  name    = "ti"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.194.132"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_797569126c60298d37016985e6cc1d3d" {
  name    = "titanium"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.194.132"
  zone_id = var.zone_id
}

# Directs to Fastly
resource "cloudflare_record" "terraform_managed_resource_6042f1baf2282d2d29931d87f1fdffac" {
  name    = "titanium"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.130.132"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_b57e23ae6f725bc81c86854844080837" {
  name    = "titanium"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.66.132"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_429c7a509ea774bee6efde5548b96bdc" {
  name    = "titanium"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.2.132"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_995ab471a928898407d6a4506fb7e562" {
  name    = "vpn"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "34.207.90.19"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_7d6b90d45221724d9606b8b6f55cc71e" {
  name    = "www-old-maintain-sl-presence"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "50.23.90.245"
  zone_id = var.zone_id
}

