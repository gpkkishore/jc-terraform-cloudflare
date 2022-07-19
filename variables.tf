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
  type        = list(string)
}

variable "ldap_aws_mfa_ns" {
  description = "LDAP nameserver for subdomain delegation"
  type        = list(string)
}

variable "ldap_mfa_aws_ns" {
  description = "LDAP-MFA nameserver for subdomain delegation"
  type        = list(string)
}

variable "radius_aws_ns" {
  description = "Radius nameserver for subdomain delegation"
  type        = list(string)
}

variable "test_subdomain_delegation" {
  description = "Testing subdomain delegation, will point ns for radius and ldap to hosted zone in aws Development account"
  type        = bool
  default     = false
}

variable "ldap_aws_ns_test" {
  description = "LDAP nameserver for subdomain delegation (ldap.cloudjump.dev)"
  type        = list(string)
}

variable "radius_aws_ns_test" {
  description = "Radius nameserver for subdomain delegation (radius.cloudjump.dev)"
  type        = list(string)
}

variable "awsstg_aws_ns" {
  description = "AWSSTG nameserver for subdomain delegation"
  type        = list(string)
}