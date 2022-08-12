# Contributing

The purpose of this document is to provide an explanation of the layout of this project along with documentation on how to contribute new code.

The project uses TF cloud and as such all variables are maintained in the respective cloud workspaces. Please see the [access control](access_control.md) documentation for information on getting access to the cloudflare workspaces - if you need to plan or apply any changes, this will be required.

## Adding DNS
All DNS records should be added/removed/modified strictly through Terraform code. New DNS records are created via the `cloudflare_record` resource. In the context of this project, DNS records are categorized into two groups:

**First party records**:
A first party record is any DNS record that has a value pointing to JumpCloud-managed infrastructure (for example, an A record with a value to an NLB).

All first party records should be added to the `dns_records` array in the `data_prd.tf` (see [here](../prod/data_prd.tf)) or `data_stg.tf` (see [here](../awsstg/data_stg.tf)) files. If dynamic values from the haproxy formula are necessary, both of these files have a remote state configured to allow access to the haproxy output. 

All of these records are passed in as a variable into the local `dns` module. This module will dynamically create a new `cloudflare_record` resource for every value in the array.

An example entry in the `dns_records` array: 
```hcl
{
    name    = "dundermifflin"
    value   = "127.0.0.1"
    type    = "A"
    ttl     = 1
    proxied = false
}
```

**Third party records**:
A third party record is any DNS record that has a value pointing to a third party (for example, TXT verification records or CNAMEs).

These records should be added as a new `cloudflare_record` resource in the `dns/noncore/third-party.tf` file (see [here](../modules/dns/noncore/third-party.tf). All the records in the noncore directory _are_ applied to the production zone - the name refers to DNS records that are not critical for the core infrastructure. 

An example entry:
```hcl
resource "cloudflare_record" "gsuit_verification" {
  name    = "get"
  proxied = false
  ttl     = 300
  type    = "TXT"
  value   = "google-site-verification=1234"
  zone_id = var.zone_id
}
```
---
As a disclaimer, there may be exceptions to these rules with existing DNS records. There is work in-flight to refactor existing records to conform with the new pattern. There is also additional work planned to bring parity between the process of adding first party and third party records.

## Merging, Planning and Applying TF
Every PR will run a `terraform plan` as a part of the CI process. Please verify that the plan has only expected changes.

When opening a PR, the default branch is `staging`. When a PR is merged into staging, it will auto-apply any changes to the cloudflare stg env (cloudjump.dev).

When the changes have been thoroughly tested in staging, they can be promoted to production by opening a new PR merging `staging` with `master`. Changes merged into `master` 
_will not_ auto-apply and require a manual confirmation of the apply in TF cloud.

## Testing
There are various test domains that can be added to CloudFlare (beyond stg/prod). When doing dev testing, check out a domain from this [sheet](https://docs.google.com/spreadsheets/d/1pObexRFohAkdnYCccnV92GUOOn8ubYQDK_NsnOTIaow/edit). You can experiment on the `dev-cloudflare` workspace in TF Cloud. You will need to override the `zone_name` and `cloudflare_api_token` variables with a CLI var (see the [terraform documentation](https://www.terraform.io/cloud-docs/workspaces/variables) for overriding vars).