variable "zone_id" {
    description = "Zone ID from Cloudflare Zone"
}

variable "awsstg_dnsrecords" {  
}

variable "enable_awsstg" {
  type = bool
  default = false
}