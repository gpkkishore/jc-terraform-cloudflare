The purpose of this document is to provide an explanation of the layout of this project along with documentation on how to contribute new code.

The project uses TF cloud and as such all variables are maintained in the respective cloud workspaces. Please see [access control](access_control.md) for information on getting access to the cloudflare workspaces.

## Adding DNS
All DNS records should be added/removed/modified strictly through Terraform code. New DNS records are created via the TF `cloudflare_record` resource. In the context of this project, DNS records are categorized into two groups:

**First party records**:
A first party record is any DNS record that has a value pointing to JumpCloud-managed infrastructure (for example, an A record with a value to an NLB).

All first party records should be added to `dns_records` array in the `data_prd.tf` or `data_stg.tf` files. Both of these files have a remote state configured to allow access to the haproxy output for dynamic values. 

All of these records are passed in as a variable into the local `dns` module. This module will dynamically create a new `cloudflare_record` resource for every value in the array.

An example entry: 
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

These records should be added as a new `cloudflare_record` resource in the `dns/nonprod/third-party.tf` file. As an aside, these records _are_ applied to the production zone - in this case, nonprod simply refers to DNS records that are not critical for the core infrastructure. There is work planned to refactor these records to more closely match the process for adding first party records.

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
As a disclaimer, there may be exceptions to these rules with the existing DNS records. There is work in-flight to refactor existing records to conform with the new pattern.

## Planning and Applying Plans
Every PR will run a `terraform plan` as a part of the CI process. Please verify that the plan has only expected changes. 

After merging the PR into `master`, you must manually apply the plan for both stg and prod in Terraform Cloud.

## Testing
There are various test domains that can be added to CloudFlare (beyond stg/prod). When doing dev testing, check out a domain from this [sheet](https://docs.google.com/spreadsheets/d/1pObexRFohAkdnYCccnV92GUOOn8ubYQDK_NsnOTIaow/edit). You can experiement on the `dev-cloudflare` workspace in CloudFront. You will need to override the `zone_name` and `cloudflare_api_token` variables with a CLI var (see https://www.terraform.io/cloud-docs/workspaces/variables).