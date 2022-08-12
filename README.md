# Cloudflare Terraform Module for JumpCloud

## Documentation
* [Access control](docs/access_control.md)
* [Contributing](docs/contributing.md)

## Module Goals

The purpose of this module is to capture, document, and automate the desired
state of a Cloudflare Website as JumpCloud's global frontend. This module is
intended to be part of a greater set of component modules that will
capture/document/automate the desired production state of the whole JumpCloud
system. Therefore, this module is designed to be loosely coupled, and capable
of being used independently.

## Terminology

Websites - In Cloudflare, a website is equivalent to a DNS Zone or AWS Route 53
Hosted Zone. Each website needs to be licensed to enable Enterprise features.

Origin Server - Public service endpoint that will be under the protection of
Cloudflare features.

## Usage

| Input | Type | Description |
|-------|------|-------------|
| cloudflare_api_token | string | API Token for Cloudflare |
 zone_name | string | Domain/Website to be used and provisioned |

### CLI
```
terraform validate
```

### Terraform Cloud via CLI
First you'll need to log in to TF cloud:
```
terraform login
```

After logging in and initializing terraform, plan/apply commands will run in the cloud.

### Terraform CLoud via Github PR
All PRs will auto-run plans in terraform cloud. Please take time to verify that these plans only have expected changes before merging.
