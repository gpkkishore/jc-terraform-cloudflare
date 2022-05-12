variable "zone_id" {
    description = "Zone ID from Cloudflare Zone"
}

variable "ldap_aws_ns" {}

variable "awsstg_dns_records" {
}

variable "enable_awsstg" {
  type    = bool
  default = false
}
<<<<<<< HEAD

variable "zone_name" {}

variable "enable_nonprod" {
  description = "Feature flag for the jumpcloud.com non-production, non-customer facing records"
  type        = bool
  default     = false
}
=======
>>>>>>> 68dfaf328e3c4a5d0984e2725bbafaab292d824a
