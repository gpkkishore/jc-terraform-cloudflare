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

variable "enable_noncore" {
  description = "Feature flag for the jumpcloud.com non-core, non-customer facing records"
  type        = bool
  default     = false
}
