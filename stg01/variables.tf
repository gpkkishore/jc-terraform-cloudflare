variable "cloudflare_api_token" {
  description = "Cloudflare API token"
}

variable "zone_name" {
  description = "Domain name"
}

variable "zone_plan" {
  default     = "enterprise"
  description = "Cloudflare plan type specification for zone"
}

variable "env" {
  default     = "stg01"
  description = "Tag for the current environment"
}

variable "project_name" {
  default     = "cloudflare"
  description = "Short project name for tagged resources"
}

variable "datadog_log_push_api_token" {
  description = "Access token for cloudflare to push logs to datadog"
}
