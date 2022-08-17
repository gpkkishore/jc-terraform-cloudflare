# Contributing

The purpose of this document is to provide an explanation of the layout of this project along with documentation on how to contribute new code.

The project uses TF cloud and as such all variables are maintained in the respective cloud workspaces. Please see the [access control](access_control.md) documentation for information on getting access to the cloudflare workspaces - if you need to plan or apply any changes, this will be required.

## Adding DNS
All DNS records should be added/removed/modified strictly through Terraform code. New DNS records are created via the `cloudflare_record` resource, but most use-cases should not need to manually create the TF resources. Instead, they will be dynamically created with the `dns` module.

The `dns` module accepts the following variables (note, this is a non-exhaustive list):

| Input         | Type          | Description                                                                                |
|---------------|---------------|--------------------------------------------------------------------------------------------|
| dns_records   | array (tuple) | A list of DNS records to add to the zone                                                   |
| mx_records    | array (tuple) | A list of MX records to add to the zone                                                    |
| ns_delegation | array (tuple) | A list of NS for subdomain delegation. See [Subdomain delegation](###subdomain-delegation) |

An example input for dns_records:
```hcl
dns_records = [
   {
      type = "A",
      name = "@",
      value = "23.185.0.1",
      ttl = 1,
      proxied = true
   }
]
```

MX records have the same format, except they have an additional `priority` attribute and don't need to specify a `type` attribute:
```hcl
mx_records = [
   {
      name     = "@",
      value    = "aspmx.l.google.com",
      ttl      = 300,
      priority = 1
   }
]
```
---
When modifying DNS records for the CloudFlare environments (prd, stg, or tst), records can be added/removed/edited via the `data_env.tf` file (where `env` is the respective environment). 
This file contains 4 arrays: `a_records`, `mx_records`, `cname_records`, and `misc_records`. Records should be modified directly within these 4 arrays, with the following categorization:

* a_records         - All the A, AAAA, and ANAME records
* mx_records    - All the MX records. MX records MUST be in this array as they have additional attributes
* cname_records - All the CNAME records
* misc_records  - Misc records that don't fit into the other categories (i.e, TXT, SOA, SPF)

Each environment will automatically merge these arrays and they will all be passed in as the `dns_records` variable to the `dns` module.

_Note: The stg environment automatically prefixes all dns records with `awsstg.`, so this should be omitted when adding records._ 

###Subdomain Delegation
If you need to create a delegate a new subdomain, you can pass in an array (tuple) for the `ns_delegation` variable to the `dns` module.

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
All the workspaces use a versioned module source (i.e, `"git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/dns?ref=v1.0.0"`). When making changes to a module, 
it is a two-step process:
1) Create a PR with only the module change. Once this is merged into master, a new release can be made [here](https://github.com/TheJumpCloud/terraform-cloudflare/releases). 
   1) New releases should follow semver and the release notes should be generated automatically (with the "Generate release notes" button)
   2) The title should be a short description of the new changes
2) Create another PR which updates the module source version for any resources where appropriate

_Note: There is a `noncore` submodule within the `dns` module. While this module is still in use, it is deprecated and should no longer be updated._

If you need to test your module changes locally, you can update the module source to reference your current branch. This requires that your module changes are pushed to a remote branch. For example:
```hcl
module "dns" {
   source = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/dns?ref=TE-123-update-dns-module"
}
```
This allows a module to be tested/verified before it is merged and a new release is cut.

## Merging, Planning and Applying TF
Every PR will run a `terraform plan` for all the workspaces. Please verify that the plan has only expected changes.

When opening a PR, the default branch is `master`. PRs merged into master will auto-apply any changes in the `tst` and `stg` working directories (`tst-cloudflare` and `stg-cloudflare` workspaces, respectively), however changes in the `prd` workspace _must_ be applied manually in TF cloud.

## Testing
There are various test domains that can be added to CloudFlare (beyond stg/prd). When doing dev testing, check out a domain from this [sheet](https://docs.google.com/spreadsheets/d/1pObexRFohAkdnYCccnV92GUOOn8ubYQDK_NsnOTIaow/edit). You can experiment on the `dev-cloudflare` workspace in TF Cloud. You will need to override the `zone_name` and `cloudflare_api_token` variables with a CLI var (see the [terraform documentation](https://www.terraform.io/cloud-docs/workspaces/variables) for overriding vars).