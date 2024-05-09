##################################################################################################################
# Cloudflare Logpush configuration                                                                               #
# This file will serve as the main entrypoint for configuring logpush jobs via cloudflare to supported providers #
##################################################################################################################
resource "cloudflare_logpush_job" "this" {
  name             = "waf-events-job-id-${var.zone_name}"
  zone_id          = cloudflare_zone.cloudflare_zone_resource.id
  enabled          = true
  dataset          = "firewall_events"
  logpull_options  = "fields=RayName,Source,RuleId,Action,EdgeResponseStatusDatetime,EdgeColoName,ClientIP,ClientCountryName,ClientASNDescription,UserAgent,ClientRequestHTTPMethodName,ClientRequestHTTPHost,ClientRequestHTTPPath&timestamps=rfc3339"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:${var.zone_name},env:${var.env},cf_type:firewall_events"
}

# Commenting this out to remove from TF management so that we can manually create / test in the UI.
# Resource to log HTTP requests with 4xx and 5xx response
resource "cloudflare_logpush_job" "http_events_job" {
  name             = "http-events-job-${var.zone_name}"
  zone_id          = cloudflare_zone.cloudflare_zone_resource.id
  enabled          = false
  dataset          = "http_requests"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:${var.zone_name},env:${var.env},cf_type:http_requests"
  filter = jsonencode({
    "where" : {
      "key" : "EdgeResponseStatus",
      "operator" : "geq",
      "value" : 400
    }
  })

  # Overriding default lof format in order to dont' ingest sensitive data to Datadog (such as creds presented in URL query parameters), specifically ClientRequestURI field
  # You can find list of available fields here: https://developers.cloudflare.com/logs/reference/log-fields/zone/http_requests/ with their description
  logpull_options = "fields=ClientASN,ClientCountry,ClientDeviceType,ClientIP,ClientRequestBytes,ClientRequestHost,ClientRequestMethod,ClientRequestPath,ClientRequestProtocol,ClientRequestScheme,ClientRequestUserAgent,ClientSSLProtocol,ClientMTLSAuthStatus,ClientTCPRTTMs,EdgeEndTimestamp,EdgeResponseBodyBytes,EdgeResponseBytes,EdgeResponseContentType,EdgeResponseStatus,EdgeServerIP,EdgeStartTimestamp,EdgeTimeToFirstByteMs,OriginIP,OriginRequestHeaderSendDurationMs,OriginResponseDurationMs,OriginResponseHeaderReceiveDurationMs,OriginResponseStatus,OriginTCPHandshakeDurationMs,OriginTLSHandshakeDurationMs,SecurityAction,CacheCacheStatus,RayID"
}
