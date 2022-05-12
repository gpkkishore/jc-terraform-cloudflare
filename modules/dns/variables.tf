variable "zone_id" {
  description = "Zone ID from Cloudflare Zone"
}

variable "awsstg_dns_records" {
}

variable "enable_awsstg" {
  type    = bool
  default = false
}

variable "zone_name" {}

variable "enable_nonprod" {
  description = "Feature flag for the jumpcloud.com non-production, non-customer facing records"
  type        = bool
  default     = false
}