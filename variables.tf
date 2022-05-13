variable "account_email" {
  description = "Cloudflare user account email"
}

variable "account_id" {
  description = "Cloudflare user account id"
}

variable "cloudflare_api_key" {
  description = "Cloudflare API access key"
}

variable "zone_name" {
  description = "Domain name"
}

variable "zone_plan" {
  default     = "enterprise"
  description = "Cloudflare plan type specification for zone"
}

variable "awsstg_dns_records" {
  description = "Map variable of input DNS records for AWSSTG environment."
}

variable "enable_awsstg" {
  description = "Feature flag for enabling the AWSSTG DNS records for the current AWSSTG environment in the Production AWS account"
  type        = bool
  default     = true
}

variable "enable_nonprod" {
  description = "Feature flag for the jumpcloud.com non-production, non-customer facing records"
  type        = bool
  default     = false
}
variable "ldap_aws_ns" {
    description = "LDAP nameserver for subdomain delegation"
    type    = list(string)
}
