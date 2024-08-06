locals {
  aws_account        = "767397867240"
  cloudflare_account = "3c96d914c0eaa62b7b4c9960e63818f7"

  /**
   * DNS A records for the prd02 environment
   */
  prd02_a_records = []

  /**
   * DNS CNAME records for the prd02 environment
   */
  prd02_mx_records = []

  /**
   * DNS MX records for the prd02 environment
   */
  prd02_cname_records = []

  /**
   * DNS miscellaneous records for the prd02 environment
   */
  prd02_misc_records = []

  /**
   * Aggregate of all DNS records for the prd02 environment
   */
  prd02_dns_records = concat(local.prd02_a_records, local.prd02_cname_records, local.prd02_mx_records, local.prd02_misc_records)

  /**
   * NS delegation records for the prd02 environment
   * This can be used to delegate subdomains to other DNS providers or other cloudflare zones
   */
  prd02_ns_delegation_records = [
    # {
    #   name  = "id"
    #   ttl   = 300
    #   value = []
    # },
    # {
    #   name  = "ldap"
    #   ttl   = 300
    #   value = []
    # },
    # {
    #   name  = "ldap-mfa"
    #   ttl   = 300
    #   value = []
    # },
    # {
    #   name  = "pwm"
    #   ttl   = 300
    #   value = []
    # }
  ]

  /**
   * Additonal Rate Limit Rules for the prd02 environment
   */
  add_ratelimit_rules = []

  /**
   * Additonal WAF Rules for the prd02 environment
   */
  add_waf_rules = []
}
