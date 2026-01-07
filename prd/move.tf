moved {
  from = cloudflare_record.jumpcloud_ai_records["CNAME_jumpcloud.ai._nli-haproxy.ue1-prd-p01.jcplatform.dev"]
  to   = cloudflare_record.jumpcloud_ai_records["CNAME_jumpcloud.ai._nli.prd-use1.jcplatform.dev"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["*.nli_nli-haproxy.ue1-prd-p01.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.nli_nli.prd-use1.jcplatform.dev"]
}
moved {
  from = module.dns.cloudflare_record.dns_records["nli_nli-haproxy.ue1-prd-p01.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["nli_nli.prd-use1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.adbridge-kickstart.eu_adbridge-kickstart-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.adbridge-kickstart.eu_adbridge-kickstart.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.adbridge.eu_adbridge-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.adbridge.eu_adbridge.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.admin-oauth.id.eu_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.admin-oauth.id.eu_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.agent.eu_agent-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.agent.eu_agent.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.api.eu_api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.api.eu_api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.apple-mdm.eu_apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.apple-mdm.eu_apple-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.apple.mdm.eu_apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.apple.mdm.eu_apple-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.assist.eu_assist-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.assist.eu_assist.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.console.eu_console-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.console.eu_console.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.device-cert.eu_device-cert-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.device-cert.eu_device-cert.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.go.eu_go-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.go.eu_go.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.grpc.pwm.eu_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.grpc.pwm.eu_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.jumpdesk.eu_jumpdesk-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.jumpdesk.eu_jumpdesk.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.kickstart.eu_kickstart-public-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.kickstart.eu_kickstart-public.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.login.eu_login-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.login.eu_login-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.mcp.eu_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.mcp.eu_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.microsoft-mdm.eu_microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.microsoft-mdm.eu_microsoft-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.nli.eu_nli-haproxy-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.nli.eu_nli.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.oauth.eu_oauth-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.oauth.eu_oauth.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.oauth.id.eu_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.oauth.id.eu_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.private-kickstart.eu_kickstart-private-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.private-kickstart.eu_kickstart-private.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.saas.eu_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.saas.eu_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.scim.pwm.eu_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.scim.pwm.eu_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.slack.eu_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.slack.eu_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.sso.eu_sso-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.sso.eu_sso.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.trampoline.id.eu_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.trampoline.id.eu_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["adbridge-kickstart.eu_adbridge-kickstart-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["adbridge-kickstart.eu_adbridge-kickstart.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["adbridge.eu_adbridge-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["adbridge.eu_adbridge.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["admin-oauth.id.eu_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["admin-oauth.id.eu_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["agent.eu_agent-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["agent.eu_agent.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["api.eu_api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["api.eu_api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["apple-mdm.eu_apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["apple-mdm.eu_apple-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["apple.mdm.eu_apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["apple.mdm.eu_apple-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["assist.eu_assist-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["assist.eu_assist.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["bss.eu_si-bss-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["bss.eu_si-bss-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["console.eu_console-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["console.eu_console.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["device-cert.eu_device-cert-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["device-cert.eu_device-cert.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["devices.pwm.eu_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["devices.pwm.eu_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["go.eu_go-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["go.eu_go.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["grpc.pwm.eu_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["grpc.pwm.eu_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["jumpdesk.eu_jumpdesk-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["jumpdesk.eu_jumpdesk.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["kickstart.eu_kickstart-public-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["kickstart.eu_kickstart-public.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["login.eu_login-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["login.eu_login-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["mcp.eu_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["mcp.eu_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["microsoft-mdm.eu_microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["microsoft-mdm.eu_microsoft-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["nli.eu_nli-haproxy-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["nli.eu_nli.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["oauth.eu_oauth-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["oauth.eu_oauth.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["oauth.id.eu_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["oauth.id.eu_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["private-kickstart.eu_kickstart-private-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["private-kickstart.eu_kickstart-private.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["saas.eu_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["saas.eu_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["scim.pwm.eu_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["scim.pwm.eu_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["slack.eu_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["slack.eu_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["sso.eu_sso-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["sso.eu_sso.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["trampoline.id.eu_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["trampoline.id.eu_identity.prd02-euc1.jcplatform.dev"]
}

