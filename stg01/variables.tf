variable "cloudflare_api_token" {
  description = "Cloudflare API token"
}

variable "zone_name" {
  description = "Domain name"
  default     = "stg01.jumpcloud.com"
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

variable "dd_api_key" {
  description = "Access token for cloudflare to push logs to datadog"
}

variable regenerate_cloudflare_mtls_ca {
  description = "Regenerate the Cloudflare MTLS CA"
  default     = false
}
