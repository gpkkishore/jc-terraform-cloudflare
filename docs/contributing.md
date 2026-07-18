# Contributing

The purpose of this document is to provide an explanation of the layout of this project along with documentation on how to contribute new code.

The project uses TF cloud and as such all variables are maintained in the respective cloud workspaces. Please see the [access control](access_control.md) documentation for information on getting access to the cloudflare workspaces - if you need to plan or apply any changes, this will be required.

## Creating New Zones
This project supports creating new zones in both CloudFlare and Route53 (for subdomain delegation). In general, if an endpoint
needs to take advantage of CloudFlare features (DDOS, WAF, Rate Limiting, etc) then it should get a CloudFlare zone. If these
features are not required (i.e, an internal or stg endpoint) or if specific routing policies from AWS are required (i.e latency routing),
then a R53 zone should be created and delegated to from CloudFlare.

1) Creating CloudFlare zones:
All CloudFlare zones receive an enterprise license. In order to add a new zone, add a new record to the `cloudflare_zone` variable in
the `data_prd.tf` file (see [here](../prd/data_prd.tf)). New zones will be dynamically created from this array after the plan is applied (see below for information on planning/applying in the prd workspace). _After the new zone is created, the plan must be run again (and applied) in order for the new zone to get global security/zone settings applied. This can be done in the TF cloud UI._
2) Creating R53 zones:
In order to add a new zone, add a new record to the `r53_zones` variable in the `data_env.tf` file (either in stg01 or prd, dependent on what environment you're creating the zone for). New zones will
dynamically created from this array after the plan is applied. Once the zone has been created, the NS will need to be updated in CloudFlare
to properly delegate back to R53. See the section below titled "Subdomain delegation" for additional information.

## Adding DNS
All DNS records should be added/removed/modified strictly through Terraform code. New DNS records are created via the `cloudflare_record` resource, but most use-cases should not need to manually create the TF resources. Instead, they will be dynamically created with the `dns` module.

The `dns` module accepts the following variables (note, this is not an exhaustive list):

| Input         | Type          | Description                                                                              |
|---------------|---------------|------------------------------------------------------------------------------------------|
| dns_records   | array (tuple) | A list of DNS records to add to the zone                                                 |
| ns_delegation | array (tuple) | A list of NS for subdomain delegation. See [Subdomain delegation](#subdomain-delegation) |

An example input for dns_records:
```hcl
dns_records = [
   {
      name    = "@",
      proxied = true
      ttl     = 1,
      type    = "A",
      value   = "23.185.0.1",
   }
]
```

MX records have the same format, except they have an additional `priority` attribute:
```hcl
mx_records = [
   {
      name     = "@",
      priority = 1
      proxied  = false
      ttl      = 300,
      type     = "MX"
      value    = "aspmx.l.google.com",
   }
]
```

Please alphabetically sort all attributes on new entries, along with making sure the equal signs are all aligned.

---
When modifying DNS records for the CloudFlare environments (prd, stg01, or tst), records can be added/removed/edited via the `data_env.tf` file (where `env` is the respective environment).
This file contains 4 arrays: `a_records`, `mx_records`, `cname_records`, and `misc_records`. Records should be modified directly within these 4 arrays, with the following categorization:

* a_records         - All the A, AAAA, and ANAME records
* mx_records    - All the MX records
* cname_records - All the CNAME records
* misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)

Each environment will automatically merge these arrays and they will all be passed in as the `dns_records` variable to the `dns` module.

_Note: The stg01 environment automatically prefixes all dns records with `stg01.`, so this should be omitted when adding records._

### Subdomain Delegation
If you need to create a new subdomain delegation, you can pass in an array (tuple) for the `ns_delegation` variable to the `dns` module.

This array takes the following form:
```hcl
delegation_records = [
  {
    name    = "infinity"
    ttl     = 300
    value   = ["ns-1519.awsdns-61.org.", "ns-1718.awsdns-22.co.uk.", "ns-393.awsdns-49.com.", "ns-869.awsdns-44.net."]
  }
]
```

The existing workspaces already have a `subdomain_delegation.tf` file which contains local data with this array. For these workspaces, you can just add a new object to the existing array and it will be applied on the next run.

## Module Updates
All the workspaces use a module source versioned in Terraform Cloud Registry. The different modules are maintained in separate repositories:

| Module   | Repo                                                               |
|----------|--------------------------------------------------------------------|
| dns      | https://github.com/TheJumpCloud/terraform-cloudflare-dns           |                                    |
| security | https://github.com/TheJumpCloud/terraform-cloudflare-security      |
| settings | https://github.com/TheJumpCloud/terraform-cloudflare-zone-settings |

When making changes to a module, it is a two-step process:
1) Create a PR with only the module change in the respective repo. Once this is merged into master, create a new release tag.
2) Create another PR in this repo which updates the module source version for any resources where appropriate.

_Note: There is a `noncore` submodule within the `dns` module. While this module is still in use, it is deprecated and should no longer be updated._

If you need to test your module changes locally, you can update the module source to reference your current branch. This requires that your module changes are pushed to a remote branch. For example:
```hcl
module "dns" {
   source = "git@github.com:TheJumpCloud/terraform-cloudflare-dns.git?ref=TE-123-update-dns-module"
}
```
This allows a module to be tested/verified before it is merged and a new release is cut.

## Merging, Planning and Applying TF
Every PR will run a `terraform plan` for all the workspaces. Please verify that the plan has only expected changes.

When opening a PR, the default branch is `master`. PRs merged into master will auto-apply any changes in the `tst` and `stg01` working directories (`tst-cloudflare` and `stg01-cloudflare` workspaces, respectively), however changes in the `prd` workspace _must_ be applied manually in TF cloud.

## Testing
There are various test domains that can be added to CloudFlare (beyond stg01/prd). When doing dev testing, check out a domain from this [sheet](https://docs.google.com/spreadsheets/d/1pObexRFohAkdnYCccnV92GUOOn8ubYQDK_NsnOTIaow/edit). You can experiment on the `dev-cloudflare` workspace in TF Cloud. You will need to override the `zone_name` and `cloudflare_api_token` variables with a CLI var (see the [terraform documentation](https://www.terraform.io/cloud-docs/workspaces/variables) for overriding vars).

**Vault jcops mirror parity:** proxied vault child-zone origins for `eu.jcops.net` /
`in.jcops.net` live in `data/vault_jcops_mirror_*.tf` (symlinked into `prd02/` and
`prd03/`). After editing those files or `prd/data_additional.tf` `vault_*_records`,
run (prd03 IN api/app/ws brand orange rows may be mirror-only after infra-edge cutover):

```bash
pip install -r scripts/requirements.txt
python3 scripts/check_vault_jcops_mirror_parity.py
```
