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
