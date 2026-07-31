####################################################
# Brand CNAME value changes (orange LB → grey jcops.net).
# dns module for_each key is name_value — moved keeps state across rekey.
####################################################

moved {
  from = module.dns.cloudflare_record.dns_records["api_api.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["api_api.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.api_api.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.api_api.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["assist_assist.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["assist_assist.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.assist_assist.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.assist_assist.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["apple-mdm_apple-mdm.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["apple-mdm_apple-mdm.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.apple-mdm_apple-mdm.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.apple-mdm_apple-mdm.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["microsoft-mdm_microsoft-mdm.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["microsoft-mdm_microsoft-mdm.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.microsoft-mdm_microsoft-mdm.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.microsoft-mdm_microsoft-mdm.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["console_console.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["console_console.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.console_console.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.console_console.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["kickstart_kickstart-public.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["kickstart_kickstart.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.kickstart_kickstart-public.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.kickstart_kickstart.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["apple.mdm_apple-mdm.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["apple.mdm_apple.mdm.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.apple.mdm_apple-mdm.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.apple.mdm_apple.mdm.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["go_go.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["go_go.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.go_go.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.go_go.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["jumpdesk_jumpdesk.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["jumpdesk_jumpdesk.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["mcp_mcp.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["mcp_mcp.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.mcp_mcp.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.mcp_mcp.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["login_login-api.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["login_login.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.login_login-api.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.login_login.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["nli_nli.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["nli_nli.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.nli_nli.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.nli_nli.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["oauth_oauth.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["oauth_oauth.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.oauth_oauth.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.oauth_oauth.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["polaris_polaris.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["polaris_polaris.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.polaris_polaris.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.polaris_polaris.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["polaris-console_polaris-console.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["polaris-console_polaris-console.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.polaris-console_polaris-console.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.polaris-console_polaris-console.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["slack_slack.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["slack_slack.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.slack_slack.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.slack_slack.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["sso_sso.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["sso_sso.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.sso_sso.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.sso_sso.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["saas_saas.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["saas_saas.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.saas_saas.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.saas_saas.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["trino_trino.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["trino_trino.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.trino_trino.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.trino_trino.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["ssf_saas.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["ssf_ssf.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["ocsp_ocsp.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["ocsp_ocsp.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["scep_ocsp.prd-use1.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["scep_scep.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["community_zsupw73743.lithium.com"]
  to   = module.dns.cloudflare_record.dns_records["community_community.jcops.net"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["support_support.jumpcloud.com.00dg0000000jusyma2.live.siteforce.com"]
  to   = module.dns.cloudflare_record.dns_records["support_support.jcops.net"]
}
# LMS hosts reverted grey→vendor (lmspowered is on Cloudflare; jcops orange→LMS = Error 1000).
moved {
  from = module.dns.cloudflare_record.dns_records["university_university.jcops.net"]
  to   = module.dns.cloudflare_record.dns_records["university_lmsx7sxmk23m7c6vh01sl1s5ini1s980x.lb1.wl.lmspowered.com"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["partnerjcu_partnerjcu.jcops.net"]
  to   = module.dns.cloudflare_record.dns_records["partnerjcu_lmsyeso18yxkei5yaq1a65h7izi1skr86.lb1.wl.lmspowered.com"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["www_d3d61011c209cf0c2b83e5959e49829c-330411615.us-east-1.elb.amazonaws.com"]
  to   = module.dns.cloudflare_record.dns_records["www_www.jcops.net"]
}
