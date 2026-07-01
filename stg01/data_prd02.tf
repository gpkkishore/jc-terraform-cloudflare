# Retired: *.prd02.stg01.jumpcloud.com testing mirrors (TE-2010 refactor step 0).
# Former prd02_cname_records removed from Cloudflare; prd02.jumpcloud.com zone is separate.

locals {
  prd02_a_records     = []
  prd02_mx_records    = []
  prd02_cname_records = []
  prd02_misc_records  = []

  prd02_dns_records = concat(local.prd02_a_records, local.prd02_cname_records, local.prd02_mx_records, local.prd02_misc_records)
}
