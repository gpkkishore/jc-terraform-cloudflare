variable "zone_id" {
  description = "Zone ID from Cloudflare Zone"
}

variable "zone_name" {
  description = "Zone name from Cloudflare Zone"
}

variable "dns_records" {
  description = "An array of DNS records to apply to the zone"
}

variable "ns_delegation" {
  description = "An array of nameservers for subdomain delegation"
}

variable "enable_noncore" {
  description = "Feature flag for the jumpcloud.com non-core, non-customer facing records"
  type        = bool
  default     = false
}