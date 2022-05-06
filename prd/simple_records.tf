// Simple dns records from jumpcloud.com

resource "cloudflare_record" "terraform_managed_resource_5f436ab20a0aa3376823dd43bd149ce4" {
  name    = "awsstg-vpn.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "34.214.221.231"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_fafd89e1b989f6f5447d44a83205c37d" {
  name    = "delfingen-ldap.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "34.204.118.37"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_20be7eae4a23e65e4d9db0e322fab64d" {
  name    = "devopsdays.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "192.155.251.138"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_187cc1676e95faa5c4527de04a7b07f3" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "23.185.0.1"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_68f8090abf2e83b932a06ba20edcb76f" {
  name    = "kanban.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "A"
  value   = "10.240.0.53"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_d3a487f5cc49f0a674e7622cb1af09f5" {
  name    = "logging-rmq-use1b.jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "A"
  value   = "10.30.1.25"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_066e155f08e8eb05ce73e42687d425db" {
  name    = "mgmt.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.235.213.34"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_8090221c6d5fed3e1061bbfd51edbf93" {
  name    = "nat1b.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.86.131.111"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_506256035f6f51779936219d52d49799" {
  name    = "nat1c.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.86.134.208"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_acfce0cbe9f80ff8c9ca89b934d784b1" {
  name    = "nat1d.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.86.96.53"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_24a0bb2e2309ea82a8ea65b23e87b2fa" {
  name    = "o1.em.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "198.21.2.137"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_873149644be01908b3b0fdd77e91bf12" {
  name    = "o2.ptr1370.test.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "168.245.76.83"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_184ca453ac6b691e1cb640b5c81d59ca" {
  name    = "prd-jumpcloud-logging-rmq-use1c-02.jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "A"
  value   = "10.30.3.24"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_d007e34993baf7d5e0fae95320e01674" {
  name    = "radius-proxy-1.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "104.197.52.17"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_59045fc6dee170a234942eb504e2d5a9" {
  name    = "radius-proxy-2.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "130.211.179.88"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_e2190ff1e1c5b0b3cbb4aee94849b637" {
  name    = "radius-proxy-3.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "130.211.141.152"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f390ac979105f232b937c3c2b736d77f" {
  name    = "radius-proxy-4.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "130.211.178.171"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_18f7188113420fbc8a634c828551a7c0" {
  name    = "remote.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "3.90.90.234"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_915c7212287f0cfc2ea26b0d1093ea67" {
  name    = "staging.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.225.98.126"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_5d06d0acc6f9abbb36f2a6034f01a478" {
  name    = "staging-radius-proxy.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "130.211.178.124"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_21947a021697e4c65ea91317b9bbde93" {
  name    = "staging-vpn.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "104.196.2.104"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_2f9d433d0f1d4a1c80a48bbfaa782b60" {
  name    = "test.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "54.235.82.193"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_17bb370277f9302263200c7bf04d770f" {
  name    = "test-vpn.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "52.40.206.145"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f1a325db4bb779d9214cea728ffe2d3a" {
  name    = "ti.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.194.132"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f3ee1b1580af6f658e90784d66745b1d" {
  name    = "ti.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.130.132"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_1a3a74927c5538d7f2b3bf8c91c7e5b1" {
  name    = "ti.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.66.132"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_5789efcdaf41097073a9b6ee861d38d8" {
  name    = "ti.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.2.132"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_797569126c60298d37016985e6cc1d3d" {
  name    = "titanium.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.194.132"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_6042f1baf2282d2d29931d87f1fdffac" {
  name    = "titanium.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.130.132"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_b57e23ae6f725bc81c86854844080837" {
  name    = "titanium.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.66.132"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_429c7a509ea774bee6efde5548b96bdc" {
  name    = "titanium.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "151.101.2.132"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_995ab471a928898407d6a4506fb7e562" {
  name    = "vpn.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "34.207.90.19"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_ab1632ed5b757d0e3d1318d8a35464f7" {
  name    = "www.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "23.185.0.1"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_7d6b90d45221724d9606b8b6f55cc71e" {
  name    = "www-old-maintain-sl-presence.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "A"
  value   = "50.23.90.245"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_9bb19a7d138fd2f365a0035c42f872ce" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8001::1"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_d452c31cc5f76e72f78e4faf2da71199" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8000::1"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_4c6f01019af68cd95d9dd58de5b0d535" {
  name    = "www.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8001::1"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_ea02ae8f814b241e0a1a5f6cc2b13d13" {
  name    = "www.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  value   = "2620:12a:8000::1"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_19f2a955a373028fdff7ae5a80ef1f8f" {
  name    = "_1c43a89d54ecbba5174b070a2993b0fc.thirdparty.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_2fb90b68bcadad61a727022ef68730ad.ltfvzjuylp.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_1af12d9d3217f7f893995add3578f862" {
  name    = "_45568eea00d494e516c6c642168f901e.links.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_e8d318c3068ae9619dd1e863e2323cf6.zdxcnfdgtt.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_011e8c315f043a4a9d355f3cc8e95396" {
  name    = "4i6erhepmezi.community.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "gv-vqrzfzp5jml767.dv.googlehosted.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_6bbed24ca84f9c48f12d38cc2cbb1684" {
  name    = "4nplil46eu5vyxptxoqivkbrl4jgmbfq._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "4nplil46eu5vyxptxoqivkbrl4jgmbfq.dkim.amazonses.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_248ebc70ec3eaa995881489b7969c580" {
  name    = "515119.test.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_abe9935d1c0c0ded29809e4ef4d21145" {
  name    = "515119.tr.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_ae74cf004ad85ee1aa913a002adc6abc" {
  name    = "817177.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_041f8716b92ffd088c02737beb92d76a" {
  name    = "_acme-challenge.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "o1tlam9icixerjtpgp.fastly-validations.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f138f6bc0232afb96e4ad99c77f3791d" {
  name    = "assets.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d34tpyd4up8e4j.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_a97126eec97cf5b9b4c82a87cdb98e5e" {
  name    = "_c4b3516c6ad01381f7a93f5afdd63a0e.segmentcdn.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_095d2b3fe1091cc13b4f07602aa666ca.bwlshdtstt.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_6378795c5f238a3c756aa63783da243b" {
  name    = "cdn.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d304esfcsmmapa.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_2991c735592625d5afd735ad05774f06" {
  name    = "_ce6f4c628c5c139a7c72aed4f779dc5e.segment.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_502a7d3339d30a7d629703aee79d3c18.auiqqraehs.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_aba0bdf715cdef7d44839267e216fabb" {
  name    = "cloud.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "go.pardot.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_89761a0e22d8247457d436b304bad4e2" {
  name    = "community.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "zsupw73743.lithium.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_99dc7103b3184ac953e7eed95884b0de" {
  name    = "communitystage.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "zsupw73743.stage.lithium.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_31c2ad14c9eb58b89742af16f6164f37" {
  name    = "console-backup.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "classic-console-backup-1073702737.us-east-1.elb.amazonaws.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_e20d8799bc85500b136de13c7c89a6fd" {
  name    = "_d21b7f7fe0a7da98155f2b96ee86ae4d.demo.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_95905cda44f586533206930d56ea9376.kirrbxfjtw.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_62dac75ee5252f1e2b857c46a573be68" {
  name    = "daas.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "go.pardot.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_16de8503224915e6829aa7466c7f96d6" {
  name    = "demo.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d38yxozcjb68y3.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_79f400a7aab7cd7a3039f9abe32aeafc" {
  name    = "docs.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "thejumpcloud.github.io"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_2070206938cb86527aa465b3f8d46fe9" {
  name    = "_e6d6616ef2dd3189f067881600a8b4de.cdn.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_26322312694d41edb6ff975071b7ac8b.bgpjyrktby.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_9aa55619eae18afc2b818d092f64a1cf" {
  name    = "_ea68bad0dbad6ca638e3d732d7af47d3.links.tr.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_581c3924c6d9323d6aa777c742fe741f.zdxcnfdgtt.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_c9adecaea55588155a9eb02cc2867d3e" {
  name    = "_ec5ddd489ea1118a8fdf339eb040ca8c.assets.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_9bf1779c886e3f8dff84c722feb8c8b9.auiqqraehs.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_8b8013d35a70ae8fab4c2e8dbc4b2633" {
  name    = "em5874.test.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "u515119.wl120.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_2beec8571f03ab26effe5a16d7f4f19a" {
  name    = "email.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "u817177.wl.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_26cb3313b5cdda93c24847b8f6872d26" {
  name    = "em.tr.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "u515119.wl120.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_69b95140ba56a54b8eb31680e49a5fbd" {
  name    = "_f53885b8fdfd5ff0946f2d8a218907ab.links.test.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "_089a675d599ebf7e356d75096f66eaf5.zdxcnfdgtt.acm-validations.aws"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_aef719f57736d135b9e78e7cf828ad49" {
  name    = "hello.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "6c525c9f-1d46-457b-816a-6c1cd018c9a3.outrch.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_4611fbb8385b3cc10420062d7de7f485" {
  name    = "helpdesk.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "customer-sdpondemand.manageengine.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_b5764b5759279399fff0c4a6d2f4b034" {
  name    = "hmjo4qtf7j7w4mclfnvk7ohprauna75y._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "hmjo4qtf7j7w4mclfnvk7ohprauna75y.dkim.amazonses.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_aeaefb544bba716355e93e7a68fd9b5b" {
  name    = "iyz6sj6s6ncqdpx6o7esq2bc5p4zqvmd._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 600
  type    = "CNAME"
  value   = "iyz6sj6s6ncqdpx6o7esq2bc5p4zqvmd.dkim.amazonses.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_2f4cc444493304fcbcc3d3a57cd4dde5" {
  name    = "ldap.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "eu.ldap.jumpcloud.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_dd4745a68d9d6320a094cfea1cb7db55" {
  name    = "links.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d2wpzdnpqqgnhf.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_692e56edaec4fbfed9bca08e90ed7646" {
  name    = "links.test.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "dwwkmwkg0qs49.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_d35f764fe26513cd935fde82596d14ae" {
  name    = "links.tr.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d2w25ujs1ver8z.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_27b58c46d286ef15fe73b7aff75cee7a" {
  name    = "mulesoft-api-dev.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "jumpcloud-nonprod-dlb.lb.anypointdns.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_b0d6eae94f8ba08d4e997bd3aecd8083" {
  name    = "mulesoft-api.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "jumpcloud-prod-dlb.lb.anypointdns.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_648d3f4b32a54743f148fc4002918aa7" {
  name    = "mulesoft-api-qa.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "jumpcloud-nonprod-dlb.lb.anypointdns.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_35a34470fd4cc8edef2ee96d3675f23f" {
  name    = "newton.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "u2555077.wl078.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_fb1cb32f6f5f2ad4c5d4727e9e65a383" {
  name    = "nrxzskeboxtp.support.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "gv-v62jp75esvc3fm.dv.googlehosted.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_e4a7ba3ebbfefd18c326d7e85426b45b" {
  name    = "nwt2._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "nwt2.domainkey.u2555077.wl078.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_a3006d2bba2694f1190fda832b40ed48" {
  name    = "nwt._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "nwt.domainkey.u2555077.wl078.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_5dea83309fe6314655c584cf5dbe9447" {
  name    = "q3uro2isnkiaop4shvw355m2qxcovuft._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 600
  type    = "CNAME"
  value   = "q3uro2isnkiaop4shvw355m2qxcovuft.dkim.amazonses.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_8d379570e0b9225f3af54beae3dcf85f" {
  name    = "s1._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s1.domainkey.u817177.wl.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_1e6785467a92ceb24118cfbdedcb2dd1" {
  name    = "s1._domainkey.test.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s1.domainkey.u515119.wl120.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_9cdd2372e6326ec91f042470d49e4b31" {
  name    = "s1._domainkey.tr.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s1.domainkey.u515119.wl120.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_cf3bd80a8ddb9830722d551dae55e946" {
  name    = "s2._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s2.domainkey.u817177.wl.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_7ff1fa266b87409056138999ef3d281d" {
  name    = "s2._domainkey.test.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s2.domainkey.u515119.wl120.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_144f3da3aea07ebab7fac2f340075c2e" {
  name    = "s2._domainkey.tr.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "s2.domainkey.u515119.wl120.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_c234cdf50b2b3a958404290c5614e208" {
  name    = "sales.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "custom-tracking.salesloft.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_887006e0d9dd57c6f3d65afd218f3134" {
  name    = "segmentcdn.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "drboqiqixxsdu.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f4c223cba0c33fecb2ec4e44c73b5fb5" {
  name    = "segment.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "ddicegrfxscy3.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f1a5bc8d591ba2d8798677e4da077063" {
  name    = "spg2._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "spg2.domainkey.u12100069.wl070.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_0f0ed435ffa17a80fe410bd7167c8af7" {
  name    = "spg._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "spg.domainkey.u12100069.wl070.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_83e4f09660002d49d248dfa03f4f0c94" {
  name    = "stage2-kickstart.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "kickstart-priv-80762458.us-east-1.elb.amazonaws.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_c342113c612a98d25e7ef0d21026d563" {
  name    = "staging-sso.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "staging-sso-jumpcloud-com-1641889118.us-east-1.elb.amazonaws.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_c6e3def0628a6b5d920b89b273cce849" {
  name    = "static.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "static.jumpcloud.com.s3.amazonaws.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_0233ea603c4836c8cb4f7157fc0f815b" {
  name    = "status.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "nflr6k3n1c0h.stspg-customer.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_5a15dd18982f1c35e15f47345f5ca9ec" {
  name    = "statuspage-notifications.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "u12100069.wl070.sendgrid.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_6204ef0607766b7a63af00e7a4d3853d" {
  name    = "support.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "support.jumpcloud.com.00dg0000000jusyma2.live.siteforce.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_35646c78a004b1612c5f6007057fde9b" {
  name    = "test-sso.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "test-sso-jumpcloud-com-1449567499.us-east-1.elb.amazonaws.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_8ccbfb943be031b928fba31ff468c210" {
  name    = "thirdparty.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "d1zz2n9wwwifeh.cloudfront.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_3c3a0dbd2ffd6db42f2e21ff01d34712" {
  name    = "university.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "jumpcloud.thinkific.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_096c1ad2a5e8880e70fa8e6b76015a96" {
  name    = "uo7y2yqujn3utbzkkb4igs6irxlqozmf._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "CNAME"
  value   = "uo7y2yqujn3utbzkkb4igs6irxlqozmf.dkim.amazonses.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_7195378e41bb445179b3be2adce92b14" {
  name    = "w3gu2leg5uo3s625hrirxvcc54qxix7p._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 600
  type    = "CNAME"
  value   = "w3gu2leg5uo3s625hrirxvcc54qxix7p.dkim.amazonses.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_c0aabb38e0e06c6bf71a0e16a2ea4ed3" {
  name    = "w7qhqhyrfq5h.communitymail.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "gv-ypsd3resh6onop.dv.googlehosted.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_904bcd7219b436818ee7179063c04a1c" {
  name    = "zb14758130.jumpcloud.com"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "domain.zoho.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_b768e60dc1d41bb15d089ccb1db859e0" {
  name     = "jumpcloud.com"
  priority = 20
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx3.googlemail.com"
  zone_id  = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_c5bce7b1ac03f4eccafa9955e47c0d60" {
  name     = "jumpcloud.com"
  priority = 15
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx2.googlemail.com"
  zone_id  = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_d7693e2bb7f516ade6bba363b7152e1a" {
  name     = "jumpcloud.com"
  priority = 10
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt2.aspmx.l.google.com"
  zone_id  = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_cb8166958ff9523ef5ec730250808304" {
  name     = "jumpcloud.com"
  priority = 5
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "alt1.aspmx.l.google.com"
  zone_id  = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_b8243683bc1e47302a9ac3693ecfe41a" {
  name     = "jumpcloud.com"
  priority = 1
  proxied  = false
  ttl      = 300
  type     = "MX"
  value    = "aspmx.l.google.com"
  zone_id  = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_b1115f3910db3230cd9fc5a17ddcdb6d" {
  name    = "awsstg.jumpcloud.com"
  proxied = false
  ttl     = 86400
  type    = "NS"
  value   = "ns-1192.awsdns-21.org"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_adb9c6a7aa7a5b4ede8580207cc2add6" {
  name    = "awsstg.jumpcloud.com"
  proxied = false
  ttl     = 86400
  type    = "NS"
  value   = "ns-1689.awsdns-19.co.uk"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_4a3bd21c04ae1d0cf362d5c39ff32e27" {
  name    = "awsstg.jumpcloud.com"
  proxied = false
  ttl     = 86400
  type    = "NS"
  value   = "ns-811.awsdns-37.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_ed61c1709913db8488e0684b2e2675ff" {
  name    = "awsstg.jumpcloud.com"
  proxied = false
  ttl     = 86400
  type    = "NS"
  value   = "ns-241.awsdns-30.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_196b1c537db0885f8ab54f3619d2f8b1" {
  name    = "production.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-512.awsdns-00.net"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_e5fcc59da5b3577e9869cf976ebe0877" {
  name    = "production.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-1024.awsdns-00.org"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f5cd841f35f3196d3f722b15fe90239f" {
  name    = "production.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-0.awsdns-00.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f4de492c3a3b1877d98d68fa8c118fa2" {
  name    = "production.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-1536.awsdns-00.co.uk"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_ade89019080bb4b31eb53b0ad287f81a" {
  name    = "radius.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-1931.awsdns-49.co.uk.jumpcloud.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_a3fbf4d5324ba12ea6a97b11b7b2487c" {
  name    = "radius.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-1434.awsdns-51.org.jumpcloud.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_e54d194dbaeec3292cd2eb7614a19027" {
  name    = "radius.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-465.awsdns-58.com.jumpcloud.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f1843f5f077219f4888a3334c9b6c54c" {
  name    = "radius.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "NS"
  value   = "ns-585.awsdns-09.net.jumpcloud.com"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_bd48a9e812a76fb7263d3b6d8e6bdd0e" {
  name    = "200608._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGoQCNwAQdJBy23MrShs1EuHqK/dtDC33QrTqgWd9CJmtM3CK2ZiTYugkhcxnkEtGbzg+IJqcDRNkZHyoRezTf6QbinBB2dbyANEuwKI5DVRBFowQOj9zvM3IvxAEboMlb0szUjAoML94HOkKuGuCkdZ1gbVEi3GcVwrIQphal1QIDAQAB;"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_11cf036842c018ea1eded1b3ef6f26f6" {
  name    = "20160415172154pm._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSorqsTRz+OZoZDnIDLhuArKEg67rbGszbfUSJJT/WbJeQq0ROo2j5n+QhQHr84NRH0ZAF7T918iMsnRTsBC+WGP/LMW3q8ioaAMqA8sBBrx7o9Krl+pc+l9NBOTQXiuGty5+bpxAiZ1aX3pHNVG3CouTQ4PjXfB/KPOhLgqu5EQIDAQAB"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_bd6ecbe74de74a7c176daacd14c0036a" {
  name    = "_amazonses.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "VIyyasRgolHqDFIq1WTqSPY/kSbZyxqjiuUx5e5aRjQ="
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_f1008f6e7c88aa00b40f46e63c94fc8f" {
  name    = "communitymail.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=spf1 include:us.khoros-mail.com -all"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_96841f2813c7d0b36753e4b912e5b237" {
  name    = "_dashlane-challenge.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "7f4a61be9f56090225bc52db85cb313fe4518a180ec9015a700e074afd29cb59"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_b6745265fb5900f34fe566fb54904d55" {
  name    = "_dmarc.communitymail.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=DMARC1;p=none;"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_342389f98b5a39967ddadfe86484269a" {
  name    = "_dmarc.jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "v=DMARC1; p=quarantine; pct=100; rua=mailto:re+wmjldel3qjv@dmarc.postmarkapp.com; aspf=r;"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_466ea8525a178d633d4f0b00f6335456" {
  name    = "_domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "t=y; o=~;"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_7dfe328ea58e2a28975d11d265a4c011" {
  name    = "dzc.jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "MWYergCg"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_be7fafec261e4934e8b3f81718c2b7a1" {
  name    = "f1._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDcPX7U+eq4kNe12nI5LbYAjjcy3S5XqX/24bhdb7SGHD20/p7E94V8x33YbaXSdkFNKf9RZLkJ6ePFfeSwGI8iBv7vHoijNXGIcP5G9nUCoMxERixViwyz5mceJV/ap/pl9BGayx7TI44TZHCvCGm1z4EmWS/ulextYEfD5uYoCQIDAQAB"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_305251ee693a921d76c5da9553ceb09d" {
  name    = "_github-pages-challenge-thejumpcloud.docs.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "9f7e17ffd85d95aa71c833fe3fb6b6"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_da389867fc7bd425b2a9fadaf7b5b689" {
  name    = "google._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgdCANvNf4qNowdE3mVwU21s3p9PELOh7vtPvdMCUHn0XNQNZfmUmPMeEdz3a9w+EJLJXAZpUEwcB8cIyuEEBNIfZbdYXUL5vap9zGeZuetUFjEkgBiQa1R4WFzmvmmYwxAmP68qJuiUNEvmwZku5PGYmyigm29KejfsDdvz2+RwIDAQAB"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_0945e039d096e58dd0970864c0c47ba2" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "status-page-domain-verification=95l12jw930wv"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_13be4d279d95737596e627d598fe1e74" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "v=spf1 ip4:198.37.147.129 ip4:198.21.2.137 include:aspmx.pardot.com include:mktomail.com include:_spf.google.com include:spf.zoho.com include:stspg-customer.com include:_spf.salesforce.com ~all"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_b1da1956a6a3b4b93f7c8c2a14815b5d" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "keybase-site-verification=7zIYg7WmRMTATjxDjmsyfZ1mDSQt32qvLLqueITtRWc"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_e7e9e30fae021eaf7c02c4b3e930da41" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "atlassian-domain-verification=S7cYemHK6CEnnMSf+rh0HwhhCEhj18DbxhqgfQ3+FzKOqahD77KJvLx1bpfD3VHG"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_378248b15ea32fd7cf1fe4cee98995c0" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "teamviewer-sso-verification=6598ee28a09f4163a0de02d66ccd1100"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_e410eb9b0e2f1810e0ed93203a2d2299" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "pardot876401=b67cb78a7919e17e35bdfc0f418eee0ad75889c61f0d9f08435be858071da6ed"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_7f1cca46d399d4c3d8805e1380f7d543" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "mongodb-site-verification=sQTETMZ1NBS8MxdjoHZowywB56OjQOAL"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_68d6c6e51b3bcbeb71ff599e14fe2fec" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "google-site-verification=OVH-nf622AF6JVSC49PR_nwU50w-9AoskX-oyTCzCoY"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_a7d50100f09bc492c4c5cbea9ebb2591" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "apple-domain-verification=T2kDmjmutRnHcBwJ"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_c6447d05d545f13fc61dc089ea8c9552" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "00dg0000000jusyma2"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_ea49ff702f136c6a872ebdff9031e4ee" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "docusign=97988400-ba87-45ce-af9d-c12fcba2eb30"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_56c3349b4f29d61f65cc8021a439f9b8" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "MS=ms60341697"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_4b34a9e4f391034c786a982c12d63768" {
  name    = "jumpcloud.com"
  proxied = false
  ttl     = 60
  type    = "TXT"
  value   = "pardot876401=925d26cf398317c201a38d2521074b25d5544b9b41a44339862494fd8a69abdb"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_d811ccc1d298c6d95a5f32e5326583c0" {
  name    = "mx._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVXQyHMQz4LImo8bL2ESQ46Xee8N/DS5FW2DRBganCn6q+t5ameB7D3FEKp5SOFDuWld/vrrCQDCX93vbULTKFrdyxgoJGjBLHd4Y3TKo13Mon2KGO5KZvueCiHb2AV3Y8kAFFfXWEVk/lVx0XiZtq4ZfEy+KaYWqqBxwYq8HLsQIDAQAB"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_54dc2f77fec4832a10e895c67511fb04" {
  name    = "smtpapi._domainkey.email.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}

resource "cloudflare_record" "terraform_managed_resource_e22b4971e2d2dde4241dadcb86cdeea4" {
  name    = "smtpapi._domainkey.jumpcloud.com"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"
  zone_id = "0333d0c0d39e92ca6aa9550c360bbfef"
}