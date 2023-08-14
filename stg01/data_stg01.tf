# When we have new HAProxies created, pull their state here:
#data "terraform_remote_state" "haproxy_stg" {
#  backend = "remote"
#  config = {
#    organization = "jumpcloud"
#    workspaces = {
#      name = "awsstg-haproxy-formula"
#    }
#  }
#}

# See docs/contributing.md for information on how to add a DNS record.
# Note that there are the following arrays, and new records should be placed in the correct array
# stg_a_records     - All the A, AAAA, and ANAME records
# stg_mx_records    - All the MX records. MX records MUST be in this array as they have additional attributes
# stg_cname_records - All the CNAME records
# stg_misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)
locals {
  # The name used in the custom_certs object is only used for internal metadata
  custom_certs = []

  r53_zones = []

  stg_a_records = []

  stg_mx_records = []

  stg_cname_records = []

  stg_misc_records = []

  stg_dns_records = concat(local.stg_a_records, local.stg_cname_records, local.stg_mx_records, local.stg_misc_records)
}
