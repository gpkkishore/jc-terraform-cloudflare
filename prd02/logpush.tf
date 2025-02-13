# TF for setting up logpush jobs for Cloudflare WAF logs to Datadog for `prd02.jumpcloud.com` zone
resource "cloudflare_logpush_job" "waf_events_job_prd02_jumpcloud_com" {
  name             = "waf-events-job-prd02-jumpcloud-com"
  zone_id          = "ff98526a0ac4c501ff0f48c8113e42a3"
  enabled          = true
  dataset          = "firewall_events"
  logpull_options  = "fields=RayName,Source,RuleId,Action,EdgeResponseStatusDatetime,EdgeColoName,ClientIP,ClientCountryName,ClientASNDescription,UserAgent,ClientRequestHTTPMethodName,ClientRequestHTTPHost,ClientRequestHTTPPath&timestamps=rfc3339"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:prd02.jumpcloud.com,env:prd,cf_type:firewall_events"
}

# TF for setting up logpush jobs for Cloudflare HTTP Access logs to Datadog for `prd02.jumpcloud.com` zone
resource "cloudflare_logpush_job" "http_events_job_prd02_jumpcloud_com" {
  name             = "http-events-job-prd02-jumpcloud-com"
  zone_id          = "ff98526a0ac4c501ff0f48c8113e42a3"
  enabled          = true
  dataset          = "http_requests"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:prd02.jumpcloud.com,env:prd,cf_type:http_requests"
  filter = "{\"where\":{\"and\":[{\"and\":[{\"key\":\"EdgeResponseStatus\",\"operator\":\"geq\",\"value\":400}]}]}}"
  logpull_options = "fields=ClientASN,ClientCountry,ClientDeviceType,ClientIP,ClientRequestBytes,ClientRequestHost,ClientRequestMethod,ClientRequestPath,ClientRequestProtocol,ClientRequestScheme,ClientRequestUserAgent,ClientSSLProtocol,ClientMTLSAuthStatus,ClientTCPRTTMs,EdgeEndTimestamp,EdgeResponseBodyBytes,EdgeResponseBytes,EdgeResponseContentType,EdgeResponseStatus,EdgeServerIP,EdgeStartTimestamp,EdgeTimeToFirstByteMs,OriginIP,OriginRequestHeaderSendDurationMs,OriginResponseDurationMs,OriginResponseHeaderReceiveDurationMs,OriginResponseStatus,OriginTCPHandshakeDurationMs,OriginTLSHandshakeDurationMs,SecurityAction,CacheCacheStatus,CacheResponseStatus,RayID,WorkerCPUTime,WorkerWallTimeUs,EdgeColoCode,EdgeColoID,WorkerStatus"
}