# moved blocks for state migrations go here
moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.test-kickstart
  to   = module.dns.cloudflare_record.dns_records["test-kickstart_test.jumpcloud.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.test-console
  to   = module.dns.cloudflare_record.dns_records["test-console_test.jumpcloud.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.test-agent
  to   = module.dns.cloudflare_record.dns_records["test-agent_test.jumpcloud.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_fb1cb32f6f5f2ad4c5d4727e9e65a383
  to   = module.dns.cloudflare_record.dns_records["nrxzskeboxtp.support_gv-v62jp75esvc3fm.dv.googlehosted.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_f4c223cba0c33fecb2ec4e44c73b5fb5
  to   = module.dns.cloudflare_record.dns_records["segment_ddicegrfxscy3.cloudfront.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_f3ee1b1580af6f658e90784d66745b1dc
  to   = module.dns.cloudflare_record.dns_records["ti_151.101.194.132"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_f3ee1b1580af6f658e90784d66745b1d
  to   = module.dns.cloudflare_record.dns_records["ti_151.101.130.132"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_f1a5bc8d591ba2d8798677e4da077063
  to   = module.dns.cloudflare_record.dns_records["spg2._domainkey_spg2.domainkey.u12100069.wl070.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_f138f6bc0232afb96e4ad99c77f3791d
  to   = module.dns.cloudflare_record.dns_records["assets_d34tpyd4up8e4j.cloudfront.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_f1008f6e7c88aa00b40f46e63c94fc8f
  to   = module.dns.cloudflare_record.dns_records["communitymail_v=spf1 include:us.khoros-mail.com -all"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_e4a7ba3ebbfefd18c326d7e85426b45b
  to   = module.dns.cloudflare_record.dns_records["nwt2._domainkey_nwt2.domainkey.u2555077.wl078.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_e22b4971e2d2dde4241dadcb86cdeea4
  to   = module.dns.cloudflare_record.dns_records["smtpapi._domainkey_k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_e20d8799bc85500b136de13c7c89a6fd
  to   = module.dns.cloudflare_record.dns_records["_d21b7f7fe0a7da98155f2b96ee86ae4d.demo__95905cda44f586533206930d56ea9376.kirrbxfjtw.acm-validations.aws"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_dd4745a68d9d6320a094cfea1cb7db55
  to   = module.dns.cloudflare_record.dns_records["links_d2wpzdnpqqgnhf.cloudfront.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_da389867fc7bd425b2a9fadaf7b5b6891
  to   = module.dns.cloudflare_record.dns_records["google._domainkey.get_v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCRTawG9K7tHX1tAzhyZtAu8MYsyTKRrm0oe2Sat+yT61AYPKeKXUfySU09bV2z3OWLmtzXQ3LoXadbfc4hrjPYNa6JRwkHyCy6tQz0MAhfECfg8p97TzbVu8JoAtB7LmrJsYd1EOuzriwBeOuBtTVmVWxqyxZYHuOe1vN8hZQ7KwIDAQAB"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_da389867fc7bd425b2a9fadaf7b5b689
  to   = module.dns.cloudflare_record.dns_records["google._domainkey_v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDgdCANvNf4qNowdE3mVwU21s3p9PELOh7vtPvdMCUHn0XNQNZfmUmPMeEdz3a9w+EJLJXAZpUEwcB8cIyuEEBNIfZbdYXUL5vap9zGeZuetUFjEkgBiQa1R4WFzmvmmYwxAmP68qJuiUNEvmwZku5PGYmyigm29KejfsDdvz2+RwIDAQAB"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_d811ccc1d298c6d95a5f32e5326583c0
  to   = module.dns.cloudflare_record.dns_records["mx._domainkey_k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVXQyHMQz4LImo8bL2ESQ46Xee8N/DS5FW2DRBganCn6q+t5ameB7D3FEKp5SOFDuWld/vrrCQDCX93vbULTKFrdyxgoJGjBLHd4Y3TKo13Mon2KGO5KZvueCiHb2AV3Y8kAFFfXWEVk/lVx0XiZtq4ZfEy+KaYWqqBxwYq8HLsQIDAQAB"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_d35f764fe26513cd935fde82596d14ae
  to   = module.dns.cloudflare_record.dns_records["links.tr_d2w25ujs1ver8z.cloudfront.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_cf3bd80a8ddb9830722d551dae55e946
  to   = module.dns.cloudflare_record.dns_records["s2._domainkey_s2.domainkey.u817177.wl.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_c9adecaea55588155a9eb02cc2867d3e
  to   = module.dns.cloudflare_record.dns_records["_ec5ddd489ea1118a8fdf339eb040ca8c.assets__9bf1779c886e3f8dff84c722feb8c8b9.auiqqraehs.acm-validations.aws"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_c6e3def0628a6b5d920b89b273cce849
  to   = module.dns.cloudflare_record.dns_records["static_static.jumpcloud.com.s3.amazonaws.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_c342113c612a98d25e7ef0d21026d563
  to   = module.dns.cloudflare_record.dns_records["staging-sso_staging-sso-jumpcloud-com-1641889118.us-east-1.elb.amazonaws.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_c234cdf50b2b3a958404290c5614e208
  to   = module.dns.cloudflare_record.dns_records["sales_custom-tracking.salesloft.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_c0aabb38e0e06c6bf71a0e16a2ea4ed3
  to   = module.dns.cloudflare_record.dns_records["w7qhqhyrfq5h.communitymail_gv-ypsd3resh6onop.dv.googlehosted.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_be7fafec261e4934e8b3f81718c2b7a1
  to   = module.dns.cloudflare_record.dns_records["f1._domainkey_v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDcPX7U+eq4kNe12nI5LbYAjjcy3S5XqX/24bhdb7SGHD20/p7E94V8x33YbaXSdkFNKf9RZLkJ6ePFfeSwGI8iBv7vHoijNXGIcP5G9nUCoMxERixViwyz5mceJV/ap/pl9BGayx7TI44TZHCvCGm1z4EmWS/ulextYEfD5uYoCQIDAQAB"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_bd6ecbe74de74a7c176daacd14c0036a
  to   = module.dns.cloudflare_record.dns_records["_amazonses_VIyyasRgolHqDFIq1WTqSPY/kSbZyxqjiuUx5e5aRjQ="]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_bd48a9e812a76fb7263d3b6d8e6bdd0e
  to   = module.dns.cloudflare_record.dns_records["200608._domainkey_k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDGoQCNwAQdJBy23MrShs1EuHqK/dtDC33QrTqgWd9CJmtM3CK2ZiTYugkhcxnkEtGbzg+IJqcDRNkZHyoRezTf6QbinBB2dbyANEuwKI5DVRBFowQOj9zvM3IvxAEboMlb0szUjAoML94HOkKuGuCkdZ1gbVEi3GcVwrIQphal1QIDAQAB;"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_b6745265fb5900f34fe566fb54904d55
  to   = module.dns.cloudflare_record.dns_records["_dmarc.communitymail_v=DMARC1;p=none;"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_b57e23ae6f725bc81c86854844080837
  to   = module.dns.cloudflare_record.dns_records["titanium_151.101.130.132"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_b5764b5759279399fff0c4a6d2f4b034
  to   = module.dns.cloudflare_record.dns_records["hmjo4qtf7j7w4mclfnvk7ohprauna75y._domainkey_hmjo4qtf7j7w4mclfnvk7ohprauna75y.dkim.amazonses.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_b0d6eae94f8ba08d4e997bd3aecd8083
  to   = module.dns.cloudflare_record.dns_records["mulesoft-api_jumpcloud-prod-dlb.lb.anypointdns.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_aef719f57736d135b9e78e7cf828ad49
  to   = module.dns.cloudflare_record.dns_records["hello_6c525c9f-1d46-457b-816a-6c1cd018c9a3.outrch.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_ae74cf004ad85ee1aa913a002adc6abc
  to   = module.dns.cloudflare_record.dns_records["817177_sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_acfce0cbe9f80ff8c9ca89b934d784b1
  to   = module.dns.cloudflare_record.dns_records["nat1d_54.86.96.53"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_abe9935d1c0c0ded29809e4ef4d21145
  to   = module.dns.cloudflare_record.dns_records["515119.tr_sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_aba0bdf715cdef7d44839267e216fabb
  to   = module.dns.cloudflare_record.dns_records["cloud_go.pardot.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_a97126eec97cf5b9b4c82a87cdb98e5e
  to   = module.dns.cloudflare_record.dns_records["_c4b3516c6ad01381f7a93f5afdd63a0e.segmentcdn__095d2b3fe1091cc13b4f07602aa666ca.bwlshdtstt.acm-validations.aws"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_a3006d2bba2694f1190fda832b40ed48
  to   = module.dns.cloudflare_record.dns_records["nwt._domainkey_nwt.domainkey.u2555077.wl078.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_9cdd2372e6326ec91f042470d49e4b31
  to   = module.dns.cloudflare_record.dns_records["s1._domainkey.tr_s1.domainkey.u515119.wl120.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_9aa55619eae18afc2b818d092f64a1cf
  to   = module.dns.cloudflare_record.dns_records["_ea68bad0dbad6ca638e3d732d7af47d3.links.tr__581c3924c6d9323d6aa777c742fe741f.zdxcnfdgtt.acm-validations.aws"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_99dc7103b3184ac953e7eed95884b0de
  to   = module.dns.cloudflare_record.dns_records["communitystage_zsupw73743.stage.lithium.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_995ab471a928898407d6a4506fb7e562
  to   = module.dns.cloudflare_record.dns_records["vpn_34.207.90.19"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_96841f2813c7d0b36753e4b912e5b237
  to   = module.dns.cloudflare_record.dns_records["_dashlane-challenge_7f4a61be9f56090225bc52db85cb313fe4518a180ec9015a700e074afd29cb59"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_915c7212287f0cfc2ea26b0d1093ea67
  to   = module.dns.cloudflare_record.dns_records["staging_54.225.98.126"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_904bcd7219b436818ee7179063c04a1c
  to   = module.dns.cloudflare_record.dns_records["zb14758130_domain.zoho.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_8d379570e0b9225f3af54beae3dcf85f
  to   = module.dns.cloudflare_record.dns_records["s1._domainkey_s1.domainkey.u817177.wl.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_8ccbfb943be031b928fba31ff468c210
  to   = module.dns.cloudflare_record.dns_records["thirdparty_d1zz2n9wwwifeh.cloudfront.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_8b8013d35a70ae8fab4c2e8dbc4b2633
  to   = module.dns.cloudflare_record.dns_records["em5874.test_u515119.wl120.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_89761a0e22d8247457d436b304bad4e2
  to   = module.dns.cloudflare_record.dns_records["community_zsupw73743.lithium.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_887006e0d9dd57c6f3d65afd218f3134
  to   = module.dns.cloudflare_record.dns_records["segmentcdn_drboqiqixxsdu.cloudfront.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_873149644be01908b3b0fdd77e91bf12
  to   = module.dns.cloudflare_record.dns_records["o2.ptr1370.test_168.245.76.83"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_83e4f09660002d49d248dfa03f4f0c94
  to   = module.dns.cloudflare_record.dns_records["stage2-kickstart_kickstart-priv-80762458.us-east-1.elb.amazonaws.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_8090221c6d5fed3e1061bbfd51edbf93
  to   = module.dns.cloudflare_record.dns_records["nat1b_54.86.131.111"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_7ff1fa266b87409056138999ef3d281d
  to   = module.dns.cloudflare_record.dns_records["s2._domainkey.test_s2.domainkey.u515119.wl120.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_7dfe328ea58e2a28975d11d265a4c011
  to   = module.dns.cloudflare_record.dns_records["dzc_MWYergCg"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_7d6b90d45221724d9606b8b6f55cc71e
  to   = module.dns.cloudflare_record.dns_records["www-old-maintain-sl-presence_50.23.90.245"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_79f400a7aab7cd7a3039f9abe32aeafc
  to   = module.dns.cloudflare_record.dns_records["docs_thejumpcloud.github.io"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_797569126c60298d37016985e6cc1d3d
  to   = module.dns.cloudflare_record.dns_records["titanium_151.101.2.132"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_6bbed24ca84f9c48f12d38cc2cbb1684
  to   = module.dns.cloudflare_record.dns_records["4nplil46eu5vyxptxoqivkbrl4jgmbfq._domainkey_4nplil46eu5vyxptxoqivkbrl4jgmbfq.dkim.amazonses.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_69b95140ba56a54b8eb31680e49a5fbd
  to   = module.dns.cloudflare_record.dns_records["_f53885b8fdfd5ff0946f2d8a218907ab.links.test__089a675d599ebf7e356d75096f66eaf5.zdxcnfdgtt.acm-validations.aws"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_692e56edaec4fbfed9bca08e90ed7646
  to   = module.dns.cloudflare_record.dns_records["links.test_dwwkmwkg0qs49.cloudfront.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_68f8090abf2e83b932a06ba20edcb76f
  to   = module.dns.cloudflare_record.dns_records["kanban_10.240.0.53"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_648d3f4b32a54743f148fc4002918aa7
  to   = module.dns.cloudflare_record.dns_records["mulesoft-api-qa_jumpcloud-nonprod-dlb.lb.anypointdns.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_6378795c5f238a3c756aa63783da243b
  to   = module.dns.cloudflare_record.dns_records["cdn_d304esfcsmmapa.cloudfront.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_62dac75ee5252f1e2b857c46a573be68
  to   = module.dns.cloudflare_record.dns_records["daas_go.pardot.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_6204ef0607766b7a63af00e7a4d3853d
  to   = module.dns.cloudflare_record.dns_records["support_support.jumpcloud.com.00dg0000000jusyma2.live.siteforce.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_6042f1baf2282d2d29931d87f1fdffac
  to   = module.dns.cloudflare_record.dns_records["titanium_151.101.66.132"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_5f436ab20a0aa3376823dd43bd149ce4
  to   = module.dns.cloudflare_record.dns_records["awsstg-vpn_34.214.221.231"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_5d06d0acc6f9abbb36f2a6034f01a478
  to   = module.dns.cloudflare_record.dns_records["staging-radius-proxy_130.211.178.124"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_5789efcdaf41097073a9b6ee861d38d8
  to   = module.dns.cloudflare_record.dns_records["ti_151.101.2.132"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_54dc2f77fec4832a10e895c67511fb04
  to   = module.dns.cloudflare_record.dns_records["smtpapi._domainkey.email_k=rsa; t=s; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPtW5iwpXVPiH5FzJ7Nrl8USzuY9zqqzjE0D1r04xDN6qwziDnmgcFNNfMewVKN2D1O+2J9N14hRprzByFwfQW76yojh54Xu3uSbQ3JP0A7k8o8GutRF8zbFUA8n0ZH2y0cIEjMliXY4W4LwPA7m4q0ObmvSjhd63O9d8z1XkUBwIDAQAB"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_506256035f6f51779936219d52d49799
  to   = module.dns.cloudflare_record.dns_records["nat1c_54.86.134.208"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_466ea8525a178d633d4f0b00f6335456
  to   = module.dns.cloudflare_record.dns_records["_domainkey_t=y; o=~;"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_4611fbb8385b3cc10420062d7de7f485
  to   = module.dns.cloudflare_record.dns_records["helpdesk_customer-sdpondemand.manageengine.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_429c7a509ea774bee6efde5548b96bdc
  to   = module.dns.cloudflare_record.dns_records["titanium_151.101.194.132"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_3c3a0dbd2ffd6db42f2e21ff01d34712
  to   = module.dns.cloudflare_record.dns_records["university_jumpcloud.thinkific.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_35a34470fd4cc8edef2ee96d3675f23f
  to   = module.dns.cloudflare_record.dns_records["newton_u2555077.wl078.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_35646c78a004b1612c5f6007057fde9b
  to   = module.dns.cloudflare_record.dns_records["test-sso_test-sso-jumpcloud-com-1449567499.us-east-1.elb.amazonaws.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_342389f98b5a39967ddadfe86484269a
  to   = module.dns.cloudflare_record.dns_records["_dmarc_v=DMARC1; p=quarantine; pct=100; rua=mailto:re+wmjldel3qjv@dmarc.postmarkapp.com; aspf=r;"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_322b4971e2d2dde4241dadcb86cdeea4
  to   = module.dns.cloudflare_record.dns_records["get_google-site-verification=r08R9Bf1v1aOENAAczb6YfRGr6QQt8FvsRoRFl_ySpI"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_322b4971e2d2dde4241dadcb86cdee123
  to   = module.dns.cloudflare_record.dns_records["get_v=spf1 include:sendgrid.net include:_spf.google.com ~all"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_31c2ad14c9eb58b89742af16f6164f37
  to   = module.dns.cloudflare_record.dns_records["console-backup_classic-console-backup-1073702737.us-east-1.elb.amazonaws.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_305251ee693a921d76c5da9553ceb09d
  to   = module.dns.cloudflare_record.dns_records["_github-pages-challenge-thejumpcloud.docs_9f7e17ffd85d95aa71c833fe3fb6b6"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_2f9d433d0f1d4a1c80a48bbfaa782b60
  to   = module.dns.cloudflare_record.dns_records["test_54.235.82.193"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_2beec8571f03ab26effe5a16d7f4f19a
  to   = module.dns.cloudflare_record.dns_records["email_u817177.wl.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_2991c735592625d5afd735ad05774f06
  to   = module.dns.cloudflare_record.dns_records["_ce6f4c628c5c139a7c72aed4f779dc5e.segment__502a7d3339d30a7d629703aee79d3c18.auiqqraehs.acm-validations.aws"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_27b58c46d286ef15fe73b7aff75cee7a
  to   = module.dns.cloudflare_record.dns_records["mulesoft-api-dev_jumpcloud-nonprod-dlb.lb.anypointdns.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_26cb3313b5cdda93c24847b8f6872d26
  to   = module.dns.cloudflare_record.dns_records["em.tr_u515119.wl120.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_24a0bb2e2309ea82a8ea65b23e87b2fa
  to   = module.dns.cloudflare_record.dns_records["o1.em_198.21.2.137"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_248ebc70ec3eaa995881489b7969c580
  to   = module.dns.cloudflare_record.dns_records["515119.test_sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_222b4971e2d2dde4241dadcb86cdeea4
  to   = module.dns.cloudflare_record.dns_records["try_unbouncepages.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_21947a021697e4c65ea91317b9bbde93
  to   = module.dns.cloudflare_record.dns_records["staging-vpn_104.196.2.104"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_20be7eae4a23e65e4d9db0e322fab64d
  to   = module.dns.cloudflare_record.dns_records["devopsdays_192.155.251.138"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_2070206938cb86527aa465b3f8d46fe9
  to   = module.dns.cloudflare_record.dns_records["_e6d6616ef2dd3189f067881600a8b4de.cdn__26322312694d41edb6ff975071b7ac8b.bgpjyrktby.acm-validations.aws"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_1e6785467a92ceb24118cfbdedcb2dd1
  to   = module.dns.cloudflare_record.dns_records["s1._domainkey.test_s1.domainkey.u515119.wl120.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_1af12d9d3217f7f893995add3578f862
  to   = module.dns.cloudflare_record.dns_records["_45568eea00d494e516c6c642168f901e.links__e8d318c3068ae9619dd1e863e2323cf6.zdxcnfdgtt.acm-validations.aws"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_1a3a74927c5538d7f2b3bf8c91c7e5b1
  to   = module.dns.cloudflare_record.dns_records["ti_151.101.66.132"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_19f2a955a373028fdff7ae5a80ef1f8f
  to   = module.dns.cloudflare_record.dns_records["_1c43a89d54ecbba5174b070a2993b0fc.thirdparty__2fb90b68bcadad61a727022ef68730ad.ltfvzjuylp.acm-validations.aws"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_17bb370277f9302263200c7bf04d770f
  to   = module.dns.cloudflare_record.dns_records["test-vpn_52.40.206.145"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_16de8503224915e6829aa7466c7f96d6
  to   = module.dns.cloudflare_record.dns_records["demo_d38yxozcjb68y3.cloudfront.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_144f3da3aea07ebab7fac2f340075c2e
  to   = module.dns.cloudflare_record.dns_records["s2._domainkey.tr_s2.domainkey.u515119.wl120.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_11cf036842c018ea1eded1b3ef6f26f6
  to   = module.dns.cloudflare_record.dns_records["20160415172154pm._domainkey_k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSorqsTRz+OZoZDnIDLhuArKEg67rbGszbfUSJJT/WbJeQq0ROo2j5n+QhQHr84NRH0ZAF7T918iMsnRTsBC+WGP/LMW3q8ioaAMqA8sBBrx7o9Krl+pc+l9NBOTQXiuGty5+bpxAiZ1aX3pHNVG3CouTQ4PjXfB/KPOhLgqu5EQIDAQAB"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_0f0ed435ffa17a80fe410bd7167c8af7
  to   = module.dns.cloudflare_record.dns_records["spg._domainkey_spg.domainkey.u12100069.wl070.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_096c1ad2a5e8880e70fa8e6b76015a96
  to   = module.dns.cloudflare_record.dns_records["uo7y2yqujn3utbzkkb4igs6irxlqozmf._domainkey_uo7y2yqujn3utbzkkb4igs6irxlqozmf.dkim.amazonses.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_041f8716b92ffd088c02737beb92d76a
  to   = module.dns.cloudflare_record.dns_records["_acme-challenge_o1tlam9icixerjtpgp.fastly-validations.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_0233ea603c4836c8cb4f7157fc0f815b
  to   = module.dns.cloudflare_record.dns_records["status_nflr6k3n1c0h.stspg-customer.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.terraform_managed_resource_011e8c315f043a4a9d355f3cc8e95396
  to   = module.dns.cloudflare_record.dns_records["4i6erhepmezi.community_gv-vqrzfzp5jml767.dv.googlehosted.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.sysvpn
  to   = module.dns.cloudflare_record.dns_records["sysvpn_mgmt.jumpcloud.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.statuspage-notifications
  to   = module.dns.cloudflare_record.dns_records["statuspage-notifications_u12100069.wl070.sendgrid.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.staging-kickstart
  to   = module.dns.cloudflare_record.dns_records["staging-kickstart_staging.jumpcloud.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.staging-agent
  to   = module.dns.cloudflare_record.dns_records["staging-agent_staging.jumpcloud.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.reachdesk_rd_bounce
  to   = module.dns.cloudflare_record.dns_records["rd-bounce.jumpcloud.com_pm.mtasv.net"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.reachdesk_dkim
  to   = module.dns.cloudflare_record.dns_records["20220728194105pm._domainkey.jumpcloud.com_k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCC7AFqc+rf9Wuw58oNK9KSVhUE2pDjheFtxX3u2ERVmUlVKajAL+Se31KBkdCKoyJffY+t8aYSOqL0bH5lnZdcE2XLlyGddss8h+eWf3gA/9LkXR6P31ueCpjEKzw30xKucEwPDPeJ+Ev2qBNASmrNZb51BXAl6d4YNBMOK1Dy9QIDAQAB"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_9
  to   = module.dns.cloudflare_record.dns_records["@_teamviewer-sso-verification=6598ee28a09f4163a0de02d66ccd1100"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_8
  to   = module.dns.cloudflare_record.dns_records["@_pardot876401=b67cb78a7919e17e35bdfc0f418eee0ad75889c61f0d9f08435be858071da6ed"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_7
  to   = module.dns.cloudflare_record.dns_records["@_mongodb-site-verification=sQTETMZ1NBS8MxdjoHZowywB56OjQOAL"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_6
  to   = module.dns.cloudflare_record.dns_records["@_google-site-verification=OVH-nf622AF6JVSC49PR_nwU50w-9AoskX-oyTCzCoY"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_5
  to   = module.dns.cloudflare_record.dns_records["@_apple-domain-verification=T2kDmjmutRnHcBwJ"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_4
  to   = module.dns.cloudflare_record.dns_records["@_00dg0000000jusyma2"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_3
  to   = module.dns.cloudflare_record.dns_records["@_docusign=97988400-ba87-45ce-af9d-c12fcba2eb30"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_2
  to   = module.dns.cloudflare_record.dns_records["@_MS=ms60341697"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_13
  to   = module.dns.cloudflare_record.dns_records["@_status-page-domain-verification=95l12jw930wv"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_12
  to   = module.dns.cloudflare_record.dns_records["@_v=spf1 ip4:198.37.147.129 ip4:198.21.2.137 include:et._spf.pardot.com include:mktomail.com include:_spf.google.com include:spf.zoho.com include:stspg-customer.com include:_spf.salesforce.com ~all"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_11
  to   = module.dns.cloudflare_record.dns_records["@_keybase-site-verification=7zIYg7WmRMTATjxDjmsyfZ1mDSQt32qvLLqueITtRWc"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_10
  to   = module.dns.cloudflare_record.dns_records["@_atlassian-domain-verification=S7cYemHK6CEnnMSf+rh0HwhhCEhj18DbxhqgfQ3+FzKOqahD77KJvLx1bpfD3VHG"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.main_txt_1
  to   = module.dns.cloudflare_record.dns_records["@_pardot876401=925d26cf398317c201a38d2521074b25d5544b9b41a44339862494fd8a69abdb"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.do-1241-test
  to   = module.dns.cloudflare_record.dns_records["do-1241-test_s3-website.us-east-2.amazonaws.com"]
}

moved {
  from = module.dns.module.non_prd_dns[0].cloudflare_record.devvpn
  to   = module.dns.cloudflare_record.dns_records["devvpn_mgmt.jumpcloud.com"]
}