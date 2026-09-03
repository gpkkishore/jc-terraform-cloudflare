##################################################################################################################
# Cloudflare Logpush configuration for jcops.net router zone                                                    #
# This file configures logpush jobs for the jcops.net (US) router zone to Datadog.                              #
# See: https://jumpcloud.atlassian.net/browse/TE-2240                                                           #
##################################################################################################################
resource "cloudflare_logpush_job" "jcops_net" {
  name    = "waf-events-job-id-${local.jcops_zone_name}"
  zone_id = cloudflare_zone.jcops_net.id
  enabled = true
  dataset = "firewall_events"
  output_options {
    field_names = [
      "RayName",
      "Source",
      "RuleId",
      "Action",
      "EdgeResponseStatusDatetime",
      "EdgeColoName",
      "ClientIP",
      "ClientCountryName",
      "ClientASNDescription",
      "UserAgent",
      "ClientRequestHTTPMethodName",
      "ClientRequestHTTPHost",
      "ClientRequestHTTPPath",
    ]
    record_suffix    = "}\n"
    timestamp_format = "rfc3339"
  }
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:${local.jcops_zone_name},env:prd,cf_type:firewall_events"
}

# Resource to log HTTP requests with >= 4xx responses.
# ClientRequestURI is intentionally excluded to prevent ingestion of credentials in query parameters.
resource "cloudflare_logpush_job" "jcops_net_http_events_job" {
  name             = "http-events-job-${local.jcops_zone_name}"
  zone_id          = cloudflare_zone.jcops_net.id
  enabled          = true
  dataset          = "http_requests"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:${local.jcops_zone_name},env:prd,cf_type:http_requests"
  filter = jsonencode({
    "where" : {
      "key" : "EdgeResponseStatus",
      "operator" : "geq",
      "value" : 400
    }
  })
  output_options {
    field_names = [
      "ClientASN",
      "ClientCountry",
      "ClientDeviceType",
      "ClientIP",
      "ClientRequestBytes",
      "ClientRequestHost",
      "ClientRequestMethod",
      "ClientRequestPath",
      "ClientRequestProtocol",
      "ClientRequestScheme",
      "ClientRequestUserAgent",
      "ClientSSLProtocol",
      "ClientMTLSAuthStatus",
      "ClientTCPRTTMs",
      "EdgeEndTimestamp",
      "EdgeResponseBodyBytes",
      "EdgeResponseBytes",
      "EdgeResponseContentType",
      "EdgeResponseStatus",
      "EdgeServerIP",
      "EdgeStartTimestamp",
      "EdgeTimeToFirstByteMs",
      "OriginIP",
      "OriginRequestHeaderSendDurationMs",
      "OriginResponseDurationMs",
      "OriginResponseHeaderReceiveDurationMs",
      "OriginResponseStatus",
      "OriginTCPHandshakeDurationMs",
      "OriginTLSHandshakeDurationMs",
      "SecurityAction",
      "CacheCacheStatus",
      "RayID",
    ]
    record_suffix    = "}\n"
    timestamp_format = "rfc3339"
  }
}
