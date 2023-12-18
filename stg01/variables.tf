variable "cloudflare_api_token" {
  description = "Cloudflare API token"
}


variable "cloudflare_api_token_for_id_stg01_jumpcloud_com_zone" {
  description = "Cloudflare API token for id.stg01.jumpcloud.com zone"
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

variable "dd_api_key" {
  description = "Access token for cloudflare to push logs to datadog"
}
