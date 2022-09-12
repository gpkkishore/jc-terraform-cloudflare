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

variable "env_prefix" {
  description = "environment prefix"
  type        = string
  default     = "tst"
}

variable "region_az_labels" {
  description = "Update this map with regions and AZs that will be in use for short name labeling"
  type        = map(string)

  default = {
    us-east-1  = "use1"
    us-east-1a = "use1a"
    us-east-1b = "use1b"
    us-east-1c = "use1c"
  }
}
