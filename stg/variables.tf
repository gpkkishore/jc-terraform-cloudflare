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