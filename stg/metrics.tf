##################################################################################################################
# Cloudflare Logpush configuration                                                                               #
# This file will serve as the main entrypoint for configuring logpush jobs via cloudflare to supported providers #
##################################################################################################################
resource "cloudflare_logpush_job" "waf_events_job_id_awsstg_jumpcloud_com" {
  name             = "waf-events-job-id-awsstg-jumpcloud-com"
  zone_id          = "362ec69422e56f340f270ae443c3be30"
  enabled          = true
  dataset          = "firewall_events"
  logpull_options  = "fields=RayName,Source,RuleId,Action,EdgeResponseStatusDatetime,EdgeColoName,ClientIP,ClientCountryName,ClientASNDescription,UserAgent,ClientRequestHTTPMethodName,ClientRequestHTTPHost,ClientRequestHTTPPath&timestamps=rfc3339"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.datadog_log_push_api_token}?ddsource=cloudflare?service=cloudflare?ddtags=zone_name:id.awsstg.jumpcloud.com,env:stg"
}

resource "cloudflare_logpush_job" "waf_events_job_awsstg_jumpcloud_com" {
  name             = "waf-events-job-awsstg-jumpcloud-com"
  zone_id          = "ae43596890c7d3eb76a58b08e67cdc78"
  enabled          = true
  dataset          = "firewall_events"
  logpull_options  = "fields=RayName,Source,RuleId,Action,EdgeResponseStatusDatetime,EdgeColoName,ClientIP,ClientCountryName,ClientASNDescription,UserAgent,ClientRequestHTTPMethodName,ClientRequestHTTPHost,ClientRequestHTTPPath&timestamps=rfc3339"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.datadog_log_push_api_token}?ddsource=cloudflare?service=cloudflare?ddtags=zone_name:awsstg.jumpcloud.com,env:stg"
}

resource "cloudflare_logpush_job" "waf_events_job_devopsconsortium_org" {
  name             = "waf-events-job-devopsconsortium-org"
  zone_id          = "14fa793fedd155933368f8f094629fe4"
  enabled          = true
  dataset          = "firewall_events"
  logpull_options  = "fields=RayName,Source,RuleId,Action,EdgeResponseStatusDatetime,EdgeColoName,ClientIP,ClientCountryName,ClientASNDescription,UserAgent,ClientRequestHTTPMethodName,ClientRequestHTTPHost,ClientRequestHTTPPath&timestamps=rfc3339"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.datadog_log_push_api_token}?ddsource=cloudflare?service=cloudflare?ddtags=zone_name:devopsconsortium.org,env:stg"
}