##################################################################################################################
# Cloudflare Logpush configuration                                                                               #
# This file will serve as the main entrypoint for configuring logpush jobs via cloudflare to supported providers #
##################################################################################################################
resource "cloudflare_logpush_job" "waf_events_job" {
    name = "waf-events-job"
    zone_id = cloudflare_zone.cloudflare_zone_resource.id
    enabled = true
    dataset = "firewall_events"
    logpull_options = "fields=RayName,Source,RuleId,Action,EdgeResponseStatusDatetime,EdgeColoName,ClientIP,ClientCountryName,ClientASNDescription,UserAgent,ClientRequestHTTPMethodName,ClientRequestHTTPHost,ClientRequestHTTPPath&timestamps=rfc3339"
    destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.datadog_log_push_api_token}?ddsource=cloudflare?service=cloudflare?ddtags=zone_name:${var.zone_name},env:stg"
}
