provider "cloudflare" {
  email      = var.account_email
  account_id = var.account_id
  api_key    = var.cloudflare_api_key
}

resource "cloudflare_zone" "cloudflare_zone_resource" {
  paused = false
  plan   = var.zone_plan
  type   = "full"
  zone   = var.zone_name
}

module "dns" {
  source             = "./modules/dns"
  zone_id            = cloudflare_zone.cloudflare_zone_resource.id
  awsstg_dns_records = var.awsstg_dns_records
  enable_awsstg      = var.enable_awsstg
}

module "security" {
  source  = "./modules/security"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
}

resource "cloudflare_record" "main_txt" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = cloudflare_zone.cloudflare_zone_resource.id
  value   = "\"pardot876401=925d26cf398317c201a38d2521074b25d5544b9b41a44339862494fd8a69abdb\"\"MS=ms60341697\"\"docusign=97988400-ba87-45ce-af9d-c12fcba2eb30\"\"00dg0000000jusyma2\"\"apple-domain-verification=T2kDmjmutRnHcBwJ\"\"google-site-verification=OVH-nf622AF6JVSC49PR_nwU50w-9AoskX-oyTCzCoY\"\"mongodb-site-verification=sQTETMZ1NBS8MxdjoHZowywB56OjQOAL\"\"pardot876401=b67cb78a7919e17e35bdfc0f418eee0ad75889c61f0d9f08435be858071da6ed\"\"teamviewer-sso-verification=6598ee28a09f4163a0de02d66ccd1100\"\"atlassian-domain-verification=S7cYemHK6CEnnMSf+rh0HwhhCEhj18DbxhqgfQ3+FzKOqahD77KJvLx1bpfD3VHG\"\"keybase-site-verification=7zIYg7WmRMTATjxDjmsyfZ1mDSQt32qvLLqueITtRWc\"\"v=spf1 ip4:198.37.147.129 ip4:198.21.2.137 include:aspmx.pardot.com include:mktomail.com include:_spf.google.com include:spf.zoho.com include:stspg-customer.com include:_spf.salesforce.com ~all\"\"status-page-domain-verification=95l12jw930wv\""
}