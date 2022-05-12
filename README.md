# Cloudflare Terraform Module for JumpCloud

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
| account_email | string | Email address used to reference Cloudflare account|
| cloudflare_api_key | string | API Key or API Token |
 zone_name | string | Domain/Website to be used and provisioned |

### CLI


### Terraform Cloud via CLI


### Terraform CLoud via Github PR
