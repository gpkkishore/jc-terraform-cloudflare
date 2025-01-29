# This job will push logs from Cloudflare Workers to Datadog
resource "cloudflare_logpush_job" "workers_job" {
  enabled    = true
  account_id = local.cloudflare_account
  name       = "workers-logpush-job"
  output_options {
    field_names = [
      "ClientIP",
      "ClientRequestHost",
      "ClientRequestMethod",
      "ClientRequestURI",
      "DispatchNamespace",
      "EdgeEndTimestamp",
      "EdgeResponseBytes",
      "EdgeResponseStatus",
      "EdgeStartTimestamp",
      "Entrypoint",
      "Event",
      "EventTimestampMs",
      "Exceptions",
      "Logs",
      "Outcome",
      "RayID",
      "ScriptName",
      "ScriptTags",
      "ScriptVersion",
    ]
    sample_rate = 1.00
  }
  destination_conf = "datadog://http-intake.logs.datadoghq.com/api/v2/logs?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare&service=cloudflare&ddtags=zone_name:id.jumpcloud.com,env:prd,cf_type:workers_trace_events"
  dataset          = "workers_trace_events"
}
