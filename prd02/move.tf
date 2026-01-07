moved {
  from = cloudflare_zone_dnssec.prd02_jumpcloud_com
  to   = cloudflare_zone_dnssec.zones_with_dnssec["prd02.jumpcloud.com"]
}

moved {
  from = cloudflare_zone_dnssec.zones_with_dnssec
  to   = cloudflare_zone_dnssec.child_zones_with_dnssec
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.adbridge_adbridge-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.adbridge_adbridge.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.adbridge-kickstart_adbridge-kickstart-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.adbridge-kickstart_adbridge-kickstart.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.admin-oauth.id_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.admin-oauth.id_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.agent_agent-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.agent_agent.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.api_api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.api_api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.apple-mdm_apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.apple-mdm_apple-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.apple.mdm_apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.apple.mdm_apple-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.assist_assist-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.assist_assist.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.console_console-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.console_console.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.device-cert_device-cert-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.device-cert_device-cert.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.go_go-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.go_go.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.grpc.pwm_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.grpc.pwm_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.jumpdesk_jumpdesk-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.jumpdesk_jumpdesk.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.kickstart_kickstart-public-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.kickstart_kickstart-public.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.login_login-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.login_login-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.mcp_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.mcp_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.microsoft-mdm_microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.microsoft-mdm_microsoft-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.oauth_oauth-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.oauth_oauth.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.oauth.id_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.oauth.id_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.private-kickstart_kickstart-private-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.private-kickstart_kickstart-private.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.saas_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.saas_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.scim.pwm_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.scim.pwm_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.slack_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.slack_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.sso_sso-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.sso_sso.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["*.trampoline.id_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["*.trampoline.id_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["adbridge_adbridge-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["adbridge_adbridge.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["adbridge-kickstart_adbridge-kickstart-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["adbridge-kickstart_adbridge-kickstart.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["admin-oauth.id_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["admin-oauth.id_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["agent_agent-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["agent_agent.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["api_api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["api_api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["apple-mdm_apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["apple-mdm_apple-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["apple.mdm_apple-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["apple.mdm_apple-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["assist_assist-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["assist_assist.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["bss_si-bss-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["bss_si-bss-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["console_console-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["console_console.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["device-cert_device-cert-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["device-cert_device-cert.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["devices.pwm_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["devices.pwm_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["go_go-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["go_go.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["grpc.pwm_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["grpc.pwm_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["jumpdesk_jumpdesk-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["jumpdesk_jumpdesk.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["kickstart_kickstart-public-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["kickstart_kickstart-public.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["login_login-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["login_login-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["mcp_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["mcp_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["microsoft-mdm_microsoft-mdm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["microsoft-mdm_microsoft-mdm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["oauth_oauth-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["oauth_oauth.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["oauth.id_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["oauth.id_identity.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["private-kickstart_kickstart-private-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["private-kickstart_kickstart-private.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["saas_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["saas_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["scim.pwm_pwm-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["scim.pwm_pwm.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["slack_standard-api-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["slack_standard-api.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["sso_sso-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["sso_sso.prd02-euc1.jcplatform.dev"]
}

moved {
  from = module.dns.cloudflare_record.dns_records["trampoline.id_identity-haproxy.prd02-euc1-p00.jcplatform.dev"]
  to   = module.dns.cloudflare_record.dns_records["trampoline.id_identity.prd02-euc1.jcplatform.dev"]
}

