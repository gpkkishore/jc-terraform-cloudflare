variable "cloudflare_api_token" {
  description = "Cloudflare API token"
}

variable "cloudflare_account_id" {
  description = "Cloudflare account id"
  default     = "3c96d914c0eaa62b7b4c9960e63818f7"
}

variable "zone_name" {
  description = "Domain name"
  default     = "cloudjump.dev"
}

variable "zone_plan" {
  default     = "enterprise"
  description = "Cloudflare plan type specification for zone"
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
