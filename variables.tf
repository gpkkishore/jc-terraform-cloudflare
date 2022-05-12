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

variable "ldap_aws_ns" {
    description = "LDAP nameserver for subdomain delegation"
    type    = list(string)
}