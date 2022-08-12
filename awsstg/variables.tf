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

variable "enable_awsstg" {
  description = "Feature flag for enabling the AWSSTG DNS records for the current AWSSTG environment in the Production AWS account"
  type        = bool
  default     = true
}