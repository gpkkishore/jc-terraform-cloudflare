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
    default = "enterprise"
    description = "Cloudflare plan type specification for zone"
}

variable "awsstg_dnsrecords" {
    description = "Map variable of input DNS records for AWSSTG environment."
}

variable "enable_awsstg" {
    description = "Feature flag for enabling the AWSSTG DNS records for the current AWSSTG environment in the Production AWS account"
    type = bool
    default = true
}