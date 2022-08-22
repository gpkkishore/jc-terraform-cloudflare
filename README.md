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

## Directory Structure
The directory structure is designed to support multiple environments while maintaining an effective blast radius for testing and deployments.

There are currently 3 environments:
1) `production` - jumpcloud.com
2) `stg` - awsstg.jumpcloud.com (note that awsstg has completely different DNS records than prod)
3) `tst` - cloudjump.dev (identical to production, used to test changes)

```
src
  ↳ utils  // Contains util scripts to assist development
  ↳ docs  // Contains documentation about this project and CloudFlare
  ↳ modules  // Contains TF modules used in the project
    ↳ dns  // The DNS module creates all DNS records for the zone
      ↳ noncore  // The noncore module creates DNS records that are not core to the infrastructure (deprecated)
    ↳ security  // The security module creates firewall rules required by security
  ↳ prd  // Working directory for the production CloudFlare site (jumpcloud.com)
  ↳ tst  // Working directory for the test CloudFlare site (cloudjump.dev)
  ↳ stg  // Working directory for the awsstg CloudFlare site (awsstg.jumpcloud.com)
```

Please see [Contributing](docs/contributing.md) for additional information along with info on how to add a DNS record.

## Terminology

Websites - In Cloudflare, a website is equivalent to a DNS Zone or AWS Route 53
Hosted Zone. Each website needs to be licensed to enable Enterprise features.

Origin Server - Public service endpoint that will be under the protection of
Cloudflare features.

## Usage
Some environments may have different input variables, but these are the 2 core variables required for all environments.  

| Input                | Type   | Description                               |
|----------------------|--------|-------------------------------------------|
| cloudflare_api_token | string | API Token for Cloudflare                  |
| zone_name            | string | Domain/Website to be used and provisioned |

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
