# Original jumpcloud.com CNAME records from Route 53

resource "cloudflare_record" "terraform_managed_resource_ae74cf004ad85ee1aa913a002adc6abc" {
  name    = "817177"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_041f8716b92ffd088c02737beb92d76a" {
  name    = "_acme-challenge"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "o1tlam9icixerjtpgp.fastly-validations.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_6bbed24ca84f9c48f12d38cc2cbb1684" {
  name    = "4nplil46eu5vyxptxoqivkbrl4jgmbfq._domainkey"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "4nplil46eu5vyxptxoqivkbrl4jgmbfq.dkim.amazonses.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_b5764b5759279399fff0c4a6d2f4b034" {
  name    = "hmjo4qtf7j7w4mclfnvk7ohprauna75y._domainkey"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "hmjo4qtf7j7w4mclfnvk7ohprauna75y.dkim.amazonses.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_aeaefb544bba716355e93e7a68fd9b5b" {
  name    = "iyz6sj6s6ncqdpx6o7esq2bc5p4zqvmd._domainkey"
  proxied = false
  ttl     = 600
  type    = "CNAME"
  value   = "iyz6sj6s6ncqdpx6o7esq2bc5p4zqvmd.dkim.amazonses.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_a3006d2bba2694f1190fda832b40ed48" {
  name    = "nwt._domainkey"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "nwt.domainkey.u2555077.wl078.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_e4a7ba3ebbfefd18c326d7e85426b45b" {
  name    = "nwt2._domainkey"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "nwt2.domainkey.u2555077.wl078.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_5dea83309fe6314655c584cf5dbe9447" {
  name    = "q3uro2isnkiaop4shvw355m2qxcovuft._domainkey"
  proxied = false
  ttl     = 600
  type    = "CNAME"
  value   = "q3uro2isnkiaop4shvw355m2qxcovuft.dkim.amazonses.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_8d379570e0b9225f3af54beae3dcf85f" {
  name    = "s1._domainkey"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s1.domainkey.u817177.wl.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_cf3bd80a8ddb9830722d551dae55e946" {
  name    = "s2._domainkey"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s2.domainkey.u817177.wl.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_0f0ed435ffa17a80fe410bd7167c8af7" {
  name    = "spg._domainkey"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "spg.domainkey.u12100069.wl070.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f1a5bc8d591ba2d8798677e4da077063" {
  name    = "spg2._domainkey"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "spg2.domainkey.u12100069.wl070.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_096c1ad2a5e8880e70fa8e6b76015a96" {
  name    = "uo7y2yqujn3utbzkkb4igs6irxlqozmf._domainkey"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "uo7y2yqujn3utbzkkb4igs6irxlqozmf.dkim.amazonses.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_7195378e41bb445179b3be2adce92b14" {
  name    = "w3gu2leg5uo3s625hrirxvcc54qxix7p._domainkey"
  proxied = false
  ttl     = 600
  type    = "CNAME"
  value   = "w3gu2leg5uo3s625hrirxvcc54qxix7p.dkim.amazonses.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f138f6bc0232afb96e4ad99c77f3791d" {
  name    = "assets"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d34tpyd4up8e4j.cloudfront.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_c9adecaea55588155a9eb02cc2867d3e" {
  name    = "_ec5ddd489ea1118a8fdf339eb040ca8c.assets"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_9bf1779c886e3f8dff84c722feb8c8b9.auiqqraehs.acm-validations.aws"
  zone_id = var.zone_id
}



resource "cloudflare_record" "terraform_managed_resource_6378795c5f238a3c756aa63783da243b" {
  name    = "cdn"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d304esfcsmmapa.cloudfront.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_2070206938cb86527aa465b3f8d46fe9" {
  name    = "_e6d6616ef2dd3189f067881600a8b4de.cdn"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_26322312694d41edb6ff975071b7ac8b.bgpjyrktby.acm-validations.aws"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_aba0bdf715cdef7d44839267e216fabb" {
  name    = "cloud"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "go.pardot.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_89761a0e22d8247457d436b304bad4e2" {
  name    = "community"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "zsupw73743.lithium.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_011e8c315f043a4a9d355f3cc8e95396" {
  name    = "4i6erhepmezi.community"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "gv-vqrzfzp5jml767.dv.googlehosted.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_c0aabb38e0e06c6bf71a0e16a2ea4ed3" {
  name    = "w7qhqhyrfq5h.communitymail"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "gv-ypsd3resh6onop.dv.googlehosted.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_99dc7103b3184ac953e7eed95884b0de" {
  name    = "communitystage"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "zsupw73743.stage.lithium.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_31c2ad14c9eb58b89742af16f6164f37" {
  name    = "console-backup"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "classic-console-backup-1073702737.us-east-1.elb.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_62dac75ee5252f1e2b857c46a573be68" {
  name    = "daas"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "go.pardot.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_16de8503224915e6829aa7466c7f96d6" {
  name    = "demo"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d38yxozcjb68y3.cloudfront.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_e20d8799bc85500b136de13c7c89a6fd" {
  name    = "_d21b7f7fe0a7da98155f2b96ee86ae4d.demo"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_95905cda44f586533206930d56ea9376.kirrbxfjtw.acm-validations.aws"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_79f400a7aab7cd7a3039f9abe32aeafc" {
  name    = "docs"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "thejumpcloud.github.io"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_2beec8571f03ab26effe5a16d7f4f19a" {
  name    = "email"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "u817177.wl.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_aef719f57736d135b9e78e7cf828ad49" {
  name    = "hello"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "6c525c9f-1d46-457b-816a-6c1cd018c9a3.outrch.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_4611fbb8385b3cc10420062d7de7f485" {
  name    = "helpdesk"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "customer-sdpondemand.manageengine.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_dd4745a68d9d6320a094cfea1cb7db55" {
  name    = "links"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d2wpzdnpqqgnhf.cloudfront.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_1af12d9d3217f7f893995add3578f862" {
  name    = "_45568eea00d494e516c6c642168f901e.links"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_e8d318c3068ae9619dd1e863e2323cf6.zdxcnfdgtt.acm-validations.aws"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_27b58c46d286ef15fe73b7aff75cee7a" {
  name    = "mulesoft-api-dev"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "jumpcloud-nonprod-dlb.lb.anypointdns.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_b0d6eae94f8ba08d4e997bd3aecd8083" {
  name    = "mulesoft-api"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "jumpcloud-prod-dlb.lb.anypointdns.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_648d3f4b32a54743f148fc4002918aa7" {
  name    = "mulesoft-api-qa"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "jumpcloud-nonprod-dlb.lb.anypointdns.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_35a34470fd4cc8edef2ee96d3675f23f" {
  name    = "newton"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "u2555077.wl078.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_c234cdf50b2b3a958404290c5614e208" {
  name    = "sales"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "custom-tracking.salesloft.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f4c223cba0c33fecb2ec4e44c73b5fb5" {
  name    = "segment"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "ddicegrfxscy3.cloudfront.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_2991c735592625d5afd735ad05774f06" {
  name    = "_ce6f4c628c5c139a7c72aed4f779dc5e.segment"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_502a7d3339d30a7d629703aee79d3c18.auiqqraehs.acm-validations.aws"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_887006e0d9dd57c6f3d65afd218f3134" {
  name    = "segmentcdn"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "drboqiqixxsdu.cloudfront.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_a97126eec97cf5b9b4c82a87cdb98e5e" {
  name    = "_c4b3516c6ad01381f7a93f5afdd63a0e.segmentcdn"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_095d2b3fe1091cc13b4f07602aa666ca.bwlshdtstt.acm-validations.aws"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_83e4f09660002d49d248dfa03f4f0c94" {
  name    = "stage2-kickstart"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "kickstart-priv-80762458.us-east-1.elb.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "staging-console" {
  count   = 0
  name    = "staging-console"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "staging-console.jumpcloud.com.cdn.cloudflare.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_c342113c612a98d25e7ef0d21026d563" {
  name    = "staging-sso"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "staging-sso-jumpcloud-com-1641889118.us-east-1.elb.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_c6e3def0628a6b5d920b89b273cce849" {
  name    = "static"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "static.jumpcloud.com.s3.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_0233ea603c4836c8cb4f7157fc0f815b" {
  name    = "status"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "nflr6k3n1c0h.stspg-customer.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "statuspage-notifications" {
  name    = "statuspage-notifications"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "u12100069.wl070.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_6204ef0607766b7a63af00e7a4d3853d" {
  name    = "support"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "support.jumpcloud.com.00dg0000000jusyma2.live.siteforce.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_fb1cb32f6f5f2ad4c5d4727e9e65a383" {
  name    = "nrxzskeboxtp.support"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "gv-v62jp75esvc3fm.dv.googlehosted.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_35646c78a004b1612c5f6007057fde9b" {
  name    = "test-sso"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "test-sso-jumpcloud-com-1449567499.us-east-1.elb.amazonaws.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_248ebc70ec3eaa995881489b7969c580" {
  name    = "515119.test"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_1e6785467a92ceb24118cfbdedcb2dd1" {
  name    = "s1._domainkey.test"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s1.domainkey.u515119.wl120.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_7ff1fa266b87409056138999ef3d281d" {
  name    = "s2._domainkey.test"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s2.domainkey.u515119.wl120.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_8b8013d35a70ae8fab4c2e8dbc4b2633" {
  name    = "em5874.test"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "u515119.wl120.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_692e56edaec4fbfed9bca08e90ed7646" {
  name    = "links.test"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "dwwkmwkg0qs49.cloudfront.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_69b95140ba56a54b8eb31680e49a5fbd" {
  name    = "_f53885b8fdfd5ff0946f2d8a218907ab.links.test"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_089a675d599ebf7e356d75096f66eaf5.zdxcnfdgtt.acm-validations.aws"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_8ccbfb943be031b928fba31ff468c210" {
  name    = "thirdparty"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d1zz2n9wwwifeh.cloudfront.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_19f2a955a373028fdff7ae5a80ef1f8f" {
  name    = "_1c43a89d54ecbba5174b070a2993b0fc.thirdparty"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_2fb90b68bcadad61a727022ef68730ad.ltfvzjuylp.acm-validations.aws"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_abe9935d1c0c0ded29809e4ef4d21145" {
  name    = "515119.tr"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_9cdd2372e6326ec91f042470d49e4b31" {
  name    = "s1._domainkey.tr"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s1.domainkey.u515119.wl120.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_144f3da3aea07ebab7fac2f340075c2e" {
  name    = "s2._domainkey.tr"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s2.domainkey.u515119.wl120.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_26cb3313b5cdda93c24847b8f6872d26" {
  name    = "em.tr"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "u515119.wl120.sendgrid.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_d35f764fe26513cd935fde82596d14ae" {
  name    = "links.tr"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d2w25ujs1ver8z.cloudfront.net"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_9aa55619eae18afc2b818d092f64a1cf" {
  name    = "_ea68bad0dbad6ca638e3d732d7af47d3.links.tr"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_581c3924c6d9323d6aa777c742fe741f.zdxcnfdgtt.acm-validations.aws"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_3c3a0dbd2ffd6db42f2e21ff01d34712" {
  name    = "university"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "jumpcloud.thinkific.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_904bcd7219b436818ee7179063c04a1c" {
  name    = "zb14758130"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "domain.zoho.com"
  zone_id = var.zone_id
}

# Original TXT records from jumpcloud.com
resource "cloudflare_record" "main_txt_1" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "pardot876401=925d26cf398317c201a38d2521074b25d5544b9b41a44339862494fd8a69abdb"
}

resource "cloudflare_record" "main_txt_2" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "MS=ms60341697"
}

resource "cloudflare_record" "main_txt_3" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "docusign=97988400-ba87-45ce-af9d-c12fcba2eb30"
}
resource "cloudflare_record" "main_txt_4" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "00dg0000000jusyma2"
}
resource "cloudflare_record" "main_txt_5" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "apple-domain-verification=T2kDmjmutRnHcBwJ"
}
resource "cloudflare_record" "main_txt_6" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "google-site-verification=OVH-nf622AF6JVSC49PR_nwU50w-9AoskX-oyTCzCoY"
}
resource "cloudflare_record" "main_txt_7" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "mongodb-site-verification=sQTETMZ1NBS8MxdjoHZowywB56OjQOAL"
}
resource "cloudflare_record" "main_txt_8" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "pardot876401=b67cb78a7919e17e35bdfc0f418eee0ad75889c61f0d9f08435be858071da6ed"
}
resource "cloudflare_record" "main_txt_9" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "teamviewer-sso-verification=6598ee28a09f4163a0de02d66ccd1100"
}
resource "cloudflare_record" "main_txt_10" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "atlassian-domain-verification=S7cYemHK6CEnnMSf+rh0HwhhCEhj18DbxhqgfQ3+FzKOqahD77KJvLx1bpfD3VHG"
}
resource "cloudflare_record" "main_txt_11" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "keybase-site-verification=7zIYg7WmRMTATjxDjmsyfZ1mDSQt32qvLLqueITtRWc"
}
resource "cloudflare_record" "main_txt_12" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "v=spf1 ip4:198.37.147.129 ip4:198.21.2.137 include:et._spf.pardot.com include:mktomail.com include:_spf.google.com include:spf.zoho.com include:stspg-customer.com include:_spf.salesforce.com ~all"
}
resource "cloudflare_record" "main_txt_13" {
  name    = "@"
  proxied = false
  ttl     = 60
  type    = "TXT"
  zone_id = var.zone_id
  value   = "status-page-domain-verification=95l12jw930wv"
}

resource "cloudflare_record" "terraform_managed_resource_bd48a9e812a76fb7263d3b6d8e6bdd0e" {
  name    = "200608._domainkey"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGoQCNwAQdJBy23MrShs1EuHqK/dtDC33QrTqgWd9CJmtM3CK2ZiTYugkhcxnkEtGbzg+IJqcDRNkZHyoRezTf6QbinBB2dbyANEuwKI5DVRBFowQOj9zvM3IvxAEboMlb0szUjAoML94HOkKuGuCkdZ1gbVEi3GcVwrIQphal1QIDAQAB;"
  zone_id = var.zone_id
}


resource "cloudflare_record" "terraform_managed_resource_11cf036842c018ea1eded1b3ef6f26f6" {
  name    = "20160415172154pm._domainkey"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSorqsTRz+OZoZDnIDLhuArKEg67rbGszbfUSJJT/WbJeQq0ROo2j5n+QhQHr84NRH0ZAF7T918iMsnRTsBC+WGP/LMW3q8ioaAMqA8sBBrx7o9Krl+pc+l9NBOTQXiuGty5+bpxAiZ1aX3pHNVG3CouTQ4PjXfB/KPOhLgqu5EQIDAQAB"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_bd6ecbe74de74a7c176daacd14c0036a" {
  name    = "_amazonses"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "VIyyasRgolHqDFIq1WTqSPY/kSbZyxqjiuUx5e5aRjQ="
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_f1008f6e7c88aa00b40f46e63c94fc8f" {
  name    = "communitymail"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=spf1 include:us.khoros-mail.com -all"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_96841f2813c7d0b36753e4b912e5b237" {
  name    = "_dashlane-challenge"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "7f4a61be9f56090225bc52db85cb313fe4518a180ec9015a700e074afd29cb59"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_b6745265fb5900f34fe566fb54904d55" {
  name    = "_dmarc.communitymail"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=DMARC1;p=none;"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_342389f98b5a39967ddadfe86484269a" {
  name    = "_dmarc"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "v=DMARC1; p=quarantine; pct=100; rua=mailto:re+wmjldel3qjv@dmarc.postmarkapp.com; aspf=r;"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_466ea8525a178d633d4f0b00f6335456" {
  name    = "_domainkey"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "t=y; o=~;"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_7dfe328ea58e2a28975d11d265a4c011" {
  name    = "dzc"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "MWYergCg"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_be7fafec261e4934e8b3f81718c2b7a1" {
  name    = "f1._domainkey"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDcPX7U+eq4kNe12nI5LbYAjjcy3S5XqX/24bhdb7SGHD20/p7E94V8x33YbaXSdkFNKf9RZLkJ6ePFfeSwGI8iBv7vHoijNXGIcP5G9nUCoMxERixViwyz5mceJV/ap/pl9BGayx7TI44TZHCvCGm1z4EmWS/ulextYEfD5uYoCQIDAQAB"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_305251ee693a921d76c5da9553ceb09d" {
  name    = "_github-pages-challenge-thejumpcloud.docs"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "9f7e17ffd85d95aa71c833fe3fb6b6"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_da389867fc7bd425b2a9fadaf7b5b689" {
  name    = "google._domainkey"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgdCANvNf4qNowdE3mVwU21s3p9PELOh7vtPvdMCUHn0XNQNZfmUmPMeEdz3a9w+EJLJXAZpUEwcB8cIyuEEBNIfZbdYXUL5vap9zGeZuetUFjEkgBiQa1R4WFzmvmmYwxAmP68qJuiUNEvmwZku5PGYmyigm29KejfsDdvz2+RwIDAQAB"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_da389867fc7bd425b2a9fadaf7b5b6891" {
  name    = "google._domainkey.get"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCRTawG9K7tHX1tAzhyZtAu8MYsyTKRrm0oe2Sat+yT61AYPKeKXUfySU09bV2z3OWLmtzXQ3LoXadbfc4hrjPYNa6JRwkHyCy6tQz0MAhfECfg8p97TzbVu8JoAtB7LmrJsYd1EOuzriwBeOuBtTVmVWxqyxZYHuOe1vN8hZQ7KwIDAQAB"
  zone_id = var.zone_id
}


resource "cloudflare_record" "terraform_managed_resource_d811ccc1d298c6d95a5f32e5326583c0" {
  name    = "mx._domainkey"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVXQyHMQz4LImo8bL2ESQ46Xee8N/DS5FW2DRBganCn6q+t5ameB7D3FEKp5SOFDuWld/vrrCQDCX93vbULTKFrdyxgoJGjBLHd4Y3TKo13Mon2KGO5KZvueCiHb2AV3Y8kAFFfXWEVk/lVx0XiZtq4ZfEy+KaYWqqBxwYq8HLsQIDAQAB"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_54dc2f77fec4832a10e895c67511fb04" {
  name    = "smtpapi._domainkey.email"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_e22b4971e2d2dde4241dadcb86cdeea4" {
  name    = "smtpapi._domainkey"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_222b4971e2d2dde4241dadcb86cdeea4" {
  name    = "try"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "unbouncepages.com"
  zone_id = var.zone_id
}

resource "cloudflare_record" "terraform_managed_resource_322b4971e2d2dde4241dadcb86cdeea4" {
  name    = "get"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "google-site-verification=r08R9Bf1v1aOENAAczb6YfRGr6QQt8FvsRoRFl_ySpI"
  zone_id = var.zone_id
}


resource "cloudflare_record" "terraform_managed_resource_322b4971e2d2dde4241dadcb86cdee123" {
  name    = "get"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=spf1 include:sendgrid.net include:_spf.google.com ~all"
  zone_id = var.zone_id
}

resource "cloudflare_record" "reachdesk_dkim" {
  name    = "20220728194105pm._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCC7AFqc+rf9Wuw58oNK9KSVhUE2pDjheFtxX3u2ERVmUlVKajAL+Se31KBkdCKoyJffY+t8aYSOqL0bH5lnZdcE2XLlyGddss8h+eWf3gA/9LkXR6P31ueCpjEKzw30xKucEwPDPeJ+Ev2qBNASmrNZb51BXAl6d4YNBMOK1Dy9QIDAQAB"
  zone_id = var.zone_id
}

resource "cloudflare_record" "reachdesk_rd_bounce" {
  name    = "rd-bounce.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "pm.mtasv.net"
  zone_id = var.zone_id
}
