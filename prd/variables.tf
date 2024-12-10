variable "cloudflare_api_token" {
  description = "Cloudflare API token"
}

variable "zone_name" {
  description = "Domain name"
  default    = "jumpcloud.com"
}

variable "zone_plan" {
  default     = "enterprise"
  description = "Cloudflare plan type specification for zone"
}

variable "base_prd_aws_region_use1" {
  description = "base region"
  type        = string
  default     = "us-east-1"
}

variable "env_prefix" {
  description = "environment prefix"
  type        = string
  default     = "prd"
}

variable "dd_api_key" {
  description = "Access token for cloudflare to push logs to datadog"
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
