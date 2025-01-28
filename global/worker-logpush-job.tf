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
      "EdgeEndTimestamp",
      "EdgeResponseBytes",
      "EdgeResponseStatus",
      "EdgeStartTimestamp",
      "Event",
      "EventTimestampMs",
      "Exceptions",
      "Logs",
      "Outcome",
      "RayID",
      "ScriptName",
    ]
    sample_rate = 0.01
  }
  destination_conf = "datadog://http-intake.logs.datadoghq.com/api/v2/logs?header_DD-API-KEY=${var.dd_api_key}&ddsource=cloudflare"
  dataset          = "workers_trace_events"
}
