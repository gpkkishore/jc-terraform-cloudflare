# When we have new HAProxies created, pull their state here:
#data "terraform_remote_state" "haproxy_stg01" {
#  backend = "remote"
#  config = {
#    organization = "jumpcloud"
#    workspaces = {
#      name = "stg01-haproxy-formula"
#    }
#  }
#}

# See docs/contributing.md for information on how to add a DNS record.
# Note that there are the following arrays, and new records should be placed in the correct array
# stg01_a_records     - All the A, AAAA, and ANAME records
# stg01_mx_records    - All the MX records. MX records MUST be in this array as they have additional attributes
# stg01_cname_records - All the CNAME records
# stg01_misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)
locals {
  # The name used in the custom_certs object is only used for internal metadata
  custom_certs = []

  r53_zones = []

  stg01_a_records = []

  stg01_mx_records = []

  stg01_cname_records = []

  stg01_misc_records = []

  stg01_dns_records = concat(local.stg01_a_records, local.stg01_cname_records, local.stg01_mx_records, local.stg01_misc_records)
}
