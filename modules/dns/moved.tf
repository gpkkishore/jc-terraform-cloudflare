# This is a running file with `moved` blocks as the project is refactored. In order to prevent this file from becoming
# unwieldy, moved blocks should be deleted once the state has been updated/synced with production

# NOTE: Since all these moved nameservers have the same key, normally you'd be able to consolidate them with a single move statement:
# moved {
#  from = cloudflare_record.awsstg_aws_ns
#  to   = cloudflare_record.ns_delegation
# }
# However, this is not possible for the current use case because there are multiple resources that are moving to the same resource block
# Terraform doesn't like this, so the individual resource keys must be specified
# AWSSTG NS
moved {
  from = cloudflare_record.awsstg_aws_ns["ns-241.awsdns-30.com."]
  to   = cloudflare_record.ns_delegation["ns-241.awsdns-30.com."]
}

moved {
  from = cloudflare_record.awsstg_aws_ns["ns-811.awsdns-37.net."]
  to   = cloudflare_record.ns_delegation["ns-811.awsdns-37.net."]
}

moved {
  from = cloudflare_record.awsstg_aws_ns["ns-1689.awsdns-19.co.uk."]
  to   = cloudflare_record.ns_delegation["ns-1689.awsdns-19.co.uk."]
}

moved {
  from = cloudflare_record.awsstg_aws_ns["ns-1192.awsdns-21.org."]
  to   = cloudflare_record.ns_delegation["ns-1192.awsdns-21.org."]
}

# LDAP NS
# NOTE: There are only 3 NS that are moved for LDAP. One of the original NS was misspelled, so we are intentionally omitting it here
# so the incorrect NS is destroyed and the correct NS is created
moved {
  from = cloudflare_record.ldap_aws_ns["ns-1519.awsdns-61.org."]
  to   = cloudflare_record.ns_delegation["ns-1519.awsdns-61.org."]
}

moved {
  from = cloudflare_record.ldap_aws_ns["ns-1718.awsdns-22.co.uk."]
  to   = cloudflare_record.ns_delegation["ns-1718.awsdns-22.co.uk."]
}

moved {
  from = cloudflare_record.ldap_aws_ns["ns-393.awsdns-49.com."]
  to   = cloudflare_record.ns_delegation["ns-393.awsdns-49.com."]
}

# LDAP MFA NS
moved {
  from = cloudflare_record.ldap_mfa_aws_ns["ns-1341.awsdns-39.org."]
  to   = cloudflare_record.ns_delegation["ns-1341.awsdns-39.org."]
}

moved {
  from = cloudflare_record.ldap_mfa_aws_ns["ns-246.awsdns-30.com."]
  to   = cloudflare_record.ns_delegation["ns-246.awsdns-30.com."]
}

moved {
  from = cloudflare_record.ldap_mfa_aws_ns["ns-973.awsdns-57.net."]
  to   = cloudflare_record.ns_delegation["ns-973.awsdns-57.net."]
}

moved {
  from = cloudflare_record.ldap_mfa_aws_ns["ns-2007.awsdns-58.co.uk."]
  to   = cloudflare_record.ns_delegation["ns-2007.awsdns-58.co.uk."]
}

# Radius NS
moved {
  from = cloudflare_record.radius_aws_ns["ns-1931.awsdns-49.co.uk."]
  to   = cloudflare_record.ns_delegation["ns-1931.awsdns-49.co.uk."]
}

moved {
  from = cloudflare_record.radius_aws_ns["ns-1434.awsdns-51.org."]
  to   = cloudflare_record.ns_delegation["ns-1434.awsdns-51.org."]
}

moved {
  from = cloudflare_record.radius_aws_ns["ns-465.awsdns-58.com."]
  to   = cloudflare_record.ns_delegation["ns-465.awsdns-58.com."]
}

moved {
  from = cloudflare_record.radius_aws_ns["ns-585.awsdns-09.net."]
  to   = cloudflare_record.ns_delegation["ns-585.awsdns-09.net."]
}

# Sec NS
moved {
  from = cloudflare_record.sec_aws_ns["ns-1471.awsdns-55.org."]
  to   = cloudflare_record.ns_delegation["ns-1471.awsdns-55.org."]
}

moved {
  from = cloudflare_record.sec_aws_ns["ns-1632.awsdns-12.co.uk."]
  to   = cloudflare_record.ns_delegation["ns-1632.awsdns-12.co.uk."]
}

moved {
  from = cloudflare_record.sec_aws_ns["ns-493.awsdns-61.com."]
  to   = cloudflare_record.ns_delegation["ns-493.awsdns-61.com."]
}

moved {
  from = cloudflare_record.sec_aws_ns["ns-731.awsdns-27.net."]
  to   = cloudflare_record.ns_delegation["ns-731.awsdns-27.net."]
}

# MX records
moved {
  from = cloudflare_record.terraform_managed_resource_18243683bc1e47302a8ac3693ecf453a
  to   = cloudflare_record.dns_records["get_aspmx.l.google.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_232423433bc1e47302a8ac387ecf453a
  to   = cloudflare_record.dns_records["get_alt1.aspmx.l.google.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_23244673bc1e47302a8ac3693ecf453a
  to   = cloudflare_record.dns_records["get_aspmx2.googlemail.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_b768e60dc1d41bb15d089ccb1db859e0
  to   = cloudflare_record.dns_records["@_aspmx3.googlemail.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_b8243683bc1e47302a9ac3693ecfe41a
  to   = cloudflare_record.dns_records["@_aspmx.l.google.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_c5bce7b1ac03f4eccafa9955e47c0d60
  to   = cloudflare_record.dns_records["@_aspmx2.googlemail.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_c8243683bc1e47302a9ac3693ecfe41a
  to   = cloudflare_record.dns_records["get_aspmx3.googlemail.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_cb8166958ff9523ef5ec730250808304
  to   = cloudflare_record.dns_records["@_alt1.aspmx.l.google.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_d7693e2bb7f516ade6bba363b7152e1a
  to   = cloudflare_record.dns_records["@_alt2.aspmx.l.google.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_d8243683bc1e47302a8ac3693ecfe41a
  to   = cloudflare_record.dns_records["get_alt2.aspmx.l.google.com"]
}

# DNS records
moved {
  from = cloudflare_record.marketing_website
  to   = cloudflare_record.dns_records["@_23.185.0.1"]
}

moved {
  from = cloudflare_record.prd_dns_records["adbridge"]
  to   = cloudflare_record.dns_records["adbridge_prd-adbridge-haproxy-95a0127e2a51ca9c.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["adbridge-kickstart"]
  to   = cloudflare_record.dns_records["adbridge-kickstart_prd-adbridge-kickstart-hap-15cdca89ba728b61.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["agent"]
  to   = cloudflare_record.dns_records["agent_prd-agent-haproxy-b20d9869679d351a.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["api"]
  to   = cloudflare_record.dns_records["api_prd-api-haproxy-26b2f6dff2b6c74e.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["apple-mdm"]
  to   = cloudflare_record.dns_records["apple-mdm_prd-apple-mdm-haproxy-d05a7a9d47266a34.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["apple.mdm"]
  to   = cloudflare_record.dns_records["apple.mdm_prd-apple-mdm-haproxy-d05a7a9d47266a34.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["bss"]
  to   = cloudflare_record.dns_records["bss_prd-si-bss-api-haproxy-6e046266a51cbefa.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["console"]
  to   = cloudflare_record.dns_records["console_prd-console-haproxy-7e5666187f103747.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["console.awsstg"]
  to   = cloudflare_record.dns_records["console.awsstg_dualstack.internal-awsstg-console-944155982.us-west-2.elb.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["device-cert"]
  to   = cloudflare_record.dns_records["device-cert_prd-device-cert-haproxy-4d41711b05fd478e.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["elastic"]
  to   = cloudflare_record.dns_records["elastic_prd-nlb-kibana-haproxy-e27a67d6237121da.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["events-internal-writes"]
  to   = cloudflare_record.dns_records["events-internal-writes_dualstack.internal-prd-event-internal-writes-998198845.us-east-1.elb.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["kickstart"]
  to   = cloudflare_record.dns_records["kickstart_prd-kickstart-public-haproxy-a6276758df0978b6.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["logging-rmq-admin-panel"]
  to   = cloudflare_record.dns_records["logging-rmq-admin-panel_dualstack.prd-logging-rmq-admin-panel-500485683.us-east-1.elb.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["logging-rmq-use1b"]
  to   = cloudflare_record.dns_records["logging-rmq-use1b_10.31.1.25"]
}

moved {
  from = cloudflare_record.prd_dns_records["mgmt"]
  to   = cloudflare_record.dns_records["mgmt_54.235.213.34"]
}

moved {
  from = cloudflare_record.prd_dns_records["prd-jumpcloud-logging-rmq-use1c-02"]
  to   = cloudflare_record.dns_records["prd-jumpcloud-logging-rmq-use1c-02_10.30.3.24"]
}

moved {
  from = cloudflare_record.prd_dns_records["private-kickstart"]
  to   = cloudflare_record.dns_records["private-kickstart_prd-kickstart-priv-haproxy-51a0179c97e2d9d8.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["radius-proxy-1"]
  to   = cloudflare_record.dns_records["radius-proxy-1_104.197.52.17"]
}

moved {
  from = cloudflare_record.prd_dns_records["radius-proxy-2"]
  to   = cloudflare_record.dns_records["radius-proxy-2_130.211.179.88"]
}

moved {
  from = cloudflare_record.prd_dns_records["radius-proxy-3"]
  to   = cloudflare_record.dns_records["radius-proxy-3_130.211.141.152"]
}

moved {
  from = cloudflare_record.prd_dns_records["radius-proxy-4"]
  to   = cloudflare_record.dns_records["radius-proxy-4_130.211.178.171"]
}

moved {
  from = cloudflare_record.prd_dns_records["remote"]
  to   = cloudflare_record.dns_records["remote_3.90.90.234"]
}

moved {
  from = cloudflare_record.prd_dns_records["sso"]
  to   = cloudflare_record.dns_records["sso_prd-sso-haproxy-f6664e7167075b59.elb.us-east-1.amazonaws.com"]
}

moved {
  from = cloudflare_record.prd_dns_records["sso.awsstg"]
  to   = cloudflare_record.dns_records["sso.awsstg_internal-awsstg-sso-jumpcloud-com-1395208237.us-west-2.elb.amazonaws.com"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_9bb19a7d138fd2f365a0035c42f872ce
  to   = cloudflare_record.dns_records["@_2620:12a:8001::1"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_d452c31cc5f76e72f78e4faf2da71199
  to   = cloudflare_record.dns_records["@_2620:12a:8000::1"]
}

moved {
  from = cloudflare_record.terraform_managed_resource_fafd89e1b989f6f5447d44a83205c37d
  to   = cloudflare_record.dns_records["delfingen-ldap_34.204.118.37"]
}

moved {
  from = cloudflare_record.www_aaaa_marketing_website_1
  to   = cloudflare_record.dns_records["www_2620:12a:8001::1"]
}

moved {
  from = cloudflare_record.www_aaaa_marketing_website_2
  to   = cloudflare_record.dns_records["www_2620:12a:8000::1"]
}

moved {
  from = cloudflare_record.www_marketing_website
  to   = cloudflare_record.dns_records["www_23.185.0.1"]
}
