# Access Control

## Repository Access Control
Below are the guildlines for access control of this repository:
- This repository will use the Pre-defined [roles](https://docs.github.com/en/organizations/managing-access-to-your-organizations-repositories/repository-roles-for-an-organization) from GitHub. 
- This repository and the Cloudflare service as a whole is owned by the [Platform-Edge](https://jumpcloud.atlassian.net/wiki/spaces/ET/pages/1034223726/Platform-Edge) team, and therefore will have ADMIN access.
- All of JumpCloud (JC) Engineering will have READ access to this respository.
- JC Security will have WRITE access in order to consume Cloudflare features.
- Cloud Engineering will have ADMIN access to facilitate JC production operations and CICD functions.
- IT will have WRITE access faciliate their functions and tasks.
- If you have WRITE access, you also need to submit an #it_support request to be added to the `tst-terraform-cloud-cloudflare-write`, `stg-terraform-cloud-cloudflare-write`, and `prd-terraform-cloud-cloudflare-write` teams in Terraform Cloud.

| Role  | Team                   | Notes                                 |
|-------|------------------------|---------------------------------------|
| ADMIN | jc-platform-edge       | Service and Repo Owner                |
|       | (Cloud Eng)            | Ops and CICD                          |
| WRITE | jc-securityengineering | Incident Responser and main consumers |
|       | (IT)                   |
| READ  | gh-read-all-repos      | All of JC?                            |
|       | jc-engineering         | All of JC Engineering                 |


## Cloudflare Access Control 
Below are the guidelines for access control to the CloudFlare account: 

| Role              | Team                 | Notes                                                                                                 |
|-------------------|----------------------|-------------------------------------------------------------------------------------------------------|
| Admin             | Platform - Edge      | Service and Repo Owner; full account access (minus billing and membership)                            |
|                   | (Cloud Eng)          | Ops and CICD                                                                                          |
| Incident Response | Security Engineering | Incident Responser and main consumers; has full read access, edit access for the firewall and gateway |
|                   | (IT)                 |                                                                                                       |
| Read only         | All of engineering   | Full account access, read-only                                                                        |
