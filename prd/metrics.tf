##################################################################################################################
# Cloudflare Logpush configuration                                                                               #
# This file will serve as the main entrypoint for configuring logpush jobs via cloudflare to supported providers #
##################################################################################################################
resource "cloudflare_logpush_job" "waf_events_job_id_jumpcloud_com" {
  name             = "waf-events-job"
  zone_id          = "0c4e52db7ee73e0764e3f172f3db47aa"
  enabled          = true
  dataset          = "firewall_events"
  logpull_options  = "fields=RayName,Source,RuleId,Action,EdgeResponseStatusDatetime,EdgeColoName,ClientIP,ClientCountryName,ClientASNDescription,UserAgent,ClientRequestHTTPMethodName,ClientRequestHTTPHost,ClientRequestHTTPPath&timestamps=rfc3339"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:id.jumpcloud.com,env:prd,cf_type:firewall_events"
}

resource "cloudflare_logpush_job" "waf_events_job_jumpcloud_com" {
  name             = "waf-events-job-jumpcloud-com"
  zone_id          = "4024ea03ad001927b18034ed250fb1ec"
  enabled          = true
  dataset          = "firewall_events"
  logpull_options  = "fields=RayName,Source,RuleId,Action,EdgeResponseStatusDatetime,EdgeColoName,ClientIP,ClientCountryName,ClientASNDescription,UserAgent,ClientRequestHTTPMethodName,ClientRequestHTTPHost,ClientRequestHTTPPath&timestamps=rfc3339"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:jumpcloud.com,env:prd,cf_type:firewall_events"
}


# > Due to bug in TF (https://support.cloudflare.com/hc/requests/2896222), logpush_job with filter doesn't work => we configured it manually via UI 
# # Resource to log HTTP requests with 4xx and 5xx response
# resource "cloudflare_logpush_job" "http_events_job_jumpcloud_com" {
#   name             = "http-events-job-jumpcloud-com"
#   zone_id          = "4024ea03ad001927b18034ed250fb1ec"
#   enabled          = true
#   dataset          = "http_requests"
#   destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:jumpcloud.com,env:prd,cf_type:http_requests"
#   filter = jsonencode({
#     "where" : {
#       "key" : "EdgeResponseStatus",
#       "operator" : "geq",
#       "value" : 400
#     }
#   })

#   # Overriding default lof format in order to dont' ingest sensitive data to Datadog (such as creds presented in URL query parameters), specifically ClientRequestURI field
#   # You can find list of available fields here: https://developers.cloudflare.com/logs/reference/log-fields/zone/http_requests/ with their description
#   logpull_options = "fields=ClientASN,ClientCountry,ClientDeviceType,ClientIP,ClientRequestBytes,ClientRequestHost,ClientRequestMethod,ClientRequestPath,ClientRequestProtocol,ClientRequestScheme,ClientRequestUserAgent,ClientSSLProtocol,ClientMTLSAuthStatus,ClientTCPRTTMs,EdgeEndTimestamp,EdgeResponseBodyBytes,EdgeResponseBytes,EdgeResponseContentType,EdgeResponseStatus,EdgeServerIP,EdgeStartTimestamp,EdgeTimeToFirstByteMs,OriginIP,OriginRequestHeaderSendDurationMs,OriginResponseDurationMs,OriginResponseHeaderReceiveDurationMs,OriginResponseStatus,OriginTCPHandshakeDurationMs,OriginTLSHandshakeDurationMs,SecurityAction,CacheCacheStatus,RayID"
# }

resource "cloudflare_logpush_job" "http_events_job_id_jumpcloud_com" {
  name             = "http-events-job-jumpcloud-com"
  zone_id          = "0c4e52db7ee73e0764e3f172f3db47aa"
  enabled          = true
  dataset          = "http_requests"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:id.jumpcloud.com,env:prd,cf_type:http_requests"
  filter = jsonencode({
    "where" : {
      "key" : "EdgeResponseStatus",
      "operator" : "geq",
      "value" : 500
    }
  })
  logpull_options = "fields=ClientASN,ClientCountry,ClientDeviceType,ClientIP,ClientRequestBytes,ClientRequestHost,ClientRequestMethod,ClientRequestPath,ClientRequestProtocol,ClientRequestScheme,ClientRequestUserAgent,ClientSSLProtocol,ClientMTLSAuthStatus,ClientTCPRTTMs,EdgeEndTimestamp,EdgeResponseBodyBytes,EdgeResponseBytes,EdgeResponseContentType,EdgeResponseStatus,EdgeServerIP,EdgeStartTimestamp,EdgeTimeToFirstByteMs,OriginIP,OriginRequestHeaderSendDurationMs,OriginResponseDurationMs,OriginResponseHeaderReceiveDurationMs,OriginResponseStatus,OriginTCPHandshakeDurationMs,OriginTLSHandshakeDurationMs,SecurityAction,CacheCacheStatus,RayID"
}
