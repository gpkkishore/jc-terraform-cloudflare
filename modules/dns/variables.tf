variable "zone_id" {
  description = "Zone ID from Cloudflare Zone"
}

variable "ldap_aws_ns" {
  description = "LDAP nameserver for subdomain delegation"
  type        = list(string)
}

variable "ldap_mfa_aws_ns" {}

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

variable "prd_dns_records" {

}

variable "radius_aws_ns" {}

variable "awsstg_aws_ns" {}

variable "sec_aws_ns" {
  description = "sec nameserver for subdomain delegation"
  type        = list(string)
}
