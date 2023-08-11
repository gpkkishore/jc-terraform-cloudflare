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
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.datadog_log_push_api_token}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:id.jumpcloud.com,env:prd,cf_type=firewall_events"
}

resource "cloudflare_logpush_job" "waf_events_job_jumpcloud_com" {
  name             = "waf-events-job-jumpcloud-com"
  zone_id          = "4024ea03ad001927b18034ed250fb1ec"
  enabled          = true
  dataset          = "firewall_events"
  logpull_options  = "fields=RayName,Source,RuleId,Action,EdgeResponseStatusDatetime,EdgeColoName,ClientIP,ClientCountryName,ClientASNDescription,UserAgent,ClientRequestHTTPMethodName,ClientRequestHTTPHost,ClientRequestHTTPPath&timestamps=rfc3339"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.datadog_log_push_api_token}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:jumpcloud.com,env:prd,cf_type=firewall_events"
}

# Adding resources to log unsuccessful apple-mdm HTTP requests, as an outcome of incident #20230801-macos-mdm-device-unenrollment
resource "cloudflare_logpush_job" "http_events_job_apple_mdm_jumpcloud_com" {
  name             = "http-events-job-apple-mdm-jumpcloud-com"
  zone_id          = "4024ea03ad001927b18034ed250fb1ec"
  enabled          = true
  dataset          = "http_requests"
  destination_conf = "datadog://http-intake.logs.datadoghq.com/v1/input?header_DD-API-KEY=${var.datadog_log_push_api_token}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:jumpcloud.com,env:prd,cf_type=http_requests"
  filter = jsonencode({
    "where" : {
      "and" : [
        {
          "key" : "ClientRequestHost",
          "operator" : "in",
          "value" : [
            "apple-mdm.jumpcloud.com",
            "apple.mdm.jumpcloud.com"
          ]
        },
        {
          "key" : "EdgeResponseStatus",
          "operator" : "geq",
          "value" : 400
        }
      ]
    }
  })

  # Omitting logpull_options for default log format. Will adjust as needed.
  #logpull_options = ""
}
