locals {
  stg01_hostnames = [
    "console.stg01.jumpcloud.com",
    "api.stg01.jumpcloud.com",
    "sso.stg01.jumpcloud.com",
    "kickstart.stg01.jumpcloud.com",
    "apple.mdm.stg01.jumpcloud.com",
    "assist.stg01.jumpcloud.com",
    "microsoft-mdm.stg01.jumpcloud.com",
    "login.stg01.jumpcloud.com",
    "oauth.stg01.jumpcloud.com",
    "go.stg01.jumpcloud.com",
    "polaris.stg01.jumpcloud.com",
    "saas.stg01.jumpcloud.com",
    "schema-registry.stg01.jumpcloud.com",
    "mcp.stg01.jumpcloud.com",
    "usermcp.stg01.jumpcloud.com",
    "slack.stg01.jumpcloud.com",
    "ai-aws.stg01.jumpcloud.com",
    "ocsp.stg01.jumpcloud.com",
    "scep.stg01.jumpcloud.com",
                        "*.apple.mdm.stg01.jumpcloud.com",
        "*.microsoft-mdm.stg01.jumpcloud.com",
    "*.schema-registry.stg01.jumpcloud.com",
  ]

  stg01_ip_access = []

  # PKI service hostnames (OCSP + SCEP) (shared: redirect exemption + Cloudflare rate limiting)
  pki_hostnames = [
    "ocsp.stg01.jumpcloud.com",
    "scep.stg01.jumpcloud.com",
  ]

  mcp_hostnames = [
    "mcp.stg01.jumpcloud.com",
    "usermcp.stg01.jumpcloud.com",
  ]

  ai_gateway_gcp_nat_hostnames = concat(local.mcp_hostnames, [
    "console.stg01.jumpcloud.com",
  ])

  # AI Gateway GCP Cloud NAT egress (jc-stg-ai-gateway, us-east5).
  # Manual static IPs from terraform-jc-gcp-org vpcs/stg/us-east5.
  gcp_stg01_ai_gateway_nat_egress_ips = [
    "8.231.42.108", # jc-ai-gateway-stg-nat-egress-1
    "8.231.43.130", # jc-ai-gateway-stg-nat-egress-2
  ]

  salesforce_ips = [
    "3.146.43.224/28",
    "13.56.32.176/28",
    "13.58.135.64/28",
    "13.108.0.0/14",
    "34.211.108.32/28",
    "34.226.36.48/28",
    "35.182.14.32/28",
    "66.231.80.0/20",
    "68.232.192.0/20",
    "96.43.144.0/20",
    "128.17.0.0/16",
    "128.245.0.0/16",
    "136.146.0.0/15",
    "198.245.80.0/20",
    "199.122.120.0/21",
    "204.14.232.0/21",
    "3.225.151.145",
    "3.225.240.254/32",
    "18.204.28.162/32",
    "18.211.105.61",
    "34.197.58.108",
    "34.204.111.166/32",
    "52.3.16.30",
    "52.22.251.194",
    "52.70.135.185",
    "155.226.0.0/16"
  ]

  testim_ips = [
    "100.20.244.103",
    "103.231.42.40/29",
    "103.231.79.40/29",
    "149.6.5.8/29",
    "199.7.167.10",
    "199.7.167.11",
    "199.7.167.12",
    "199.7.167.13",
    "199.7.167.14",
    "199.7.167.8",
    "199.7.167.9",
    "207.254.30.104/29",
    "207.254.54.36",
    "217.112.145.88/29",
    "23.105.12.38",
    "23.83.156.64/26",
    "3.210.61.129",
    "3.93.87.107",
    "34.204.155.122",
    "34.225.130.203",
    "35.82.102.6",
    "44.225.225.32",
    "44.227.49.133",
    "52.152.135.120/30",
    "52.6.150.234",
    "52.73.252.191",
  ]

  # CICD self-hosted GitHub Actions runner NAT gateway EIPs (642920845081)
  # us-west-2: cicd-usw2 runners VPC
  # ap-south-1: cicd-aps1 geo load-test runners VPC
  # ap-southeast-1: cicd-apse1 geo load-test runners VPC
  # eu-central-1: cicd-euc1 geo load-test runners VPC
  # sa-east-1: cicd-sae1 geo load-test runners VPC
  cicd_self_hosted_runner_natgws = join(" ", [
    "44.239.135.146",
    "54.69.255.145",
    "44.235.245.14",
    "35.154.202.19",
    "13.235.36.129",
    "3.109.31.86",
    "54.254.109.30",
    "52.77.135.47",
    "54.169.19.43",
    "63.184.219.181",
    "35.157.150.81",
    "3.77.113.127",
    "54.233.65.182",
    "56.126.151.185",
    "18.228.229.70",
  ])

  aws_vpc_ips = [
    "18.218.84.91",
    "18.223.127.56",
    "3.12.61.92",
    "3.132.240.8",
    "3.23.121.107",
    "3.23.44.17",
    "18.218.153.145",
    "18.221.197.217",
    "3.19.235.254",
    "3.146.242.224",
    "3.146.237.95",
    "3.19.161.175",
    "13.58.217.67",
    "3.17.202.62",
    "3.21.194.220",
    "54.249.101.63" # stg01-apne1-edge NAT GW
  ]

  crowdstrike_ips = [
    "13.52.148.107",
    "52.52.20.134",
    "52.43.192.139",
    "54.187.226.134",
    "35.160.117.193",
    "18.195.129.87",
    "3.73.169.253",
    "18.158.141.230"
  ]

  // Source: https://support.apple.com/en-us/102266
  apple_cidr_blocks = [
    "17.0.0.0/8"
  ]

  # jcs_* service account requests on *.stg01.jumpcloud.com hosts (NA-4759).
  # Per-API-key CF counting requires Advanced Rate Limiting (not entitled) — HAProxy (NA-4759).
  jcs_api_key_ratelimit_expression = "((ends_with(http.host, \".stg01.jumpcloud.com\") or http.host eq \"stg01.jumpcloud.com\") and len(http.request.headers[\"x-api-key\"]) > 0 and starts_with(lower(http.request.headers[\"x-api-key\"][0]), \"jcs_\"))"

  add_ratelimit_rules = [
    # Keep existing API rule first to preserve its state
    {
      action      = "block"
      description = "API rate limiting at the Edge"
      expression  = "(http.host in {\"saas.stg01.jumpcloud.com\"})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 10
        requests_per_period = 300
        mitigation_timeout  = 10
      }
    },
    # Service account API keys (jcs_*) — per-IP edge rate limit (NA-4759).
    # Org/provider fair-share is enforced in-app (service-accounts).
    # Per-API-key limits: HAProxy stick tables (NA-4759); CF header characteristics
    # require Advanced Rate Limiting plan (not available on stg01).
    # cf.colo.id is required (error 20155); counters are per-colo.
    {
      action      = "block"
      description = "Service account API key (jcs_*) per-IP rate limit - *.stg01.jumpcloud.com"
      expression  = local.jcs_api_key_ratelimit_expression

      ratelimit = {
        characteristics     = ["cf.colo.id", "ip.src"]
        counting_expression = null
        period              = 60
        requests_per_period = 100
        mitigation_timeout  = 60
      }
    },
    # PKI Rate Limiting Rules
    # Phase 1: Block clearly malformed requests before backend processing
    {
      action      = "block"
      description = "OCSP - Block requests missing Content-Type header"
      expression  = "(http.host in {\"ocsp.stg01.jumpcloud.com\"}) and not any(lower(http.request.headers.names[*])[*] eq \"content-type\")"

      ratelimit = {
        characteristics     = ["cf.colo.id", "cf.unique_visitor_id"]
        counting_expression = null
        period              = 60
        requests_per_period = 2
        mitigation_timeout  = 300
      }
    },
    # Phase 2: Cap successful responses at 3,000 per 5 minutes
    {
      action      = "block"
      description = "PKI - Successful response cap (5-minute, 3000 limit)"
      expression  = "(http.host in {${join(" ", [for host in local.pki_hostnames : format("\"%s\"", host)])}})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "cf.unique_visitor_id"]
        counting_expression = "(http.response.code eq 200)"
        period              = 300
        requests_per_period = 3000
        mitigation_timeout  = 300
      }
    },
    # Phase 3: Cap unauthorized responses at 300 per 5 minutes
    {
      action      = "block"
      description = "PKI - Unauthorized response cap (5-minute, 300 limit)"
      expression  = "(http.host in {${join(" ", [for host in local.pki_hostnames : format("\"%s\"", host)])}})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "cf.unique_visitor_id"]
        counting_expression = "(http.response.code eq 401)"
        period              = 300
        requests_per_period = 300
        mitigation_timeout  = 300
      }
    },
    # Phase 4: Safety net - overall per-IP rate limit (50 rps)
    {
      action      = "block"
      description = "PKI - Overall rate limit safety net (50 rps)"
      expression  = "(http.host in {${join(" ", [for host in local.pki_hostnames : format("\"%s\"", host)])}})"

      ratelimit = {
        characteristics     = ["cf.colo.id", "cf.unique_visitor_id"]
        counting_expression = null
        period              = 10
        requests_per_period = 500
        mitigation_timeout  = 60
      }
    }
  ]

  add_waf_rules = [
    {
      action      = "skip"
      description = "Allow Protect App"
      expression  = "(ip.src in {71.229.206.152 71.58.213.107 2a09:bac2:67ee:3d7::62:94 101.188.67.134})"
    },
    {
      action      = "skip"
      description = "Allow CrowdStrike"
      expression  = format("(http.host eq \"api.stg01.jumpcloud.com\" and http.request.uri.path eq \"/partners/v1/crowdstrike\" and http.user_agent eq \"Go-http-client/2.0\" and ip.src in {%s})", join(" ", [for ip in local.crowdstrike_ips : ip]))
    },
    {
      action      = "skip"
      description = "Allow Mac Stadium"
      expression  = "(ip.src eq 207.254.33.124)"
    },
    {
      action      = "skip"
      description = "Allow TestIM"
      expression  = format("(http.host eq \"console.stg01.jumpcloud.com\" and ip.src in {%s})", join(" ", [for ip in local.testim_ips : ip]))
    },
    {
      action      = "skip"
      description = "Tritium/Aluminium Internal Devices IP Skip"
      expression  = "(ip.src in {70.57.27.50 66.222.117.111 66.186.219.238 66.186.212.168 75.166.167.57 97.81.234.223})"
    },
    {
      action      = "skip"
      description = "Allow GCS ProxMox"
      expression  = "(ip.src in {50.194.147.163})"
    },
    // skip action for allowing aws vpcs for stg01.jumpcloud.com
    // AWS Control account NATGW EIP mappting for stg01-use2-p00 VPC:
    //   stg01-use2-p00-nat-us-east-2a -> 3.146.242.224
    //   stg01-use2-p00-nat-us-east-2b -> 3.146.237.95
    //   stg01-use2-p00-nat-us-east-2c -> 3.19.161.175
    {
      action      = "skip"
      description = "Allow AWS VPCs"
      expression  = "(http.host in {${join(" ", [for host in local.stg01_hostnames : format("\"%s\"", host)])}} and not http.user_agent contains \"Protect Staging/\" and ip.src in {${join(" ", [for ip in local.aws_vpc_ips : ip])}} and http.request.uri.path ne \"/google-emm/notifications\")"
    },
    // Allow GHA runners nat gateways
    {
      action      = "skip"
      description = "Allow GHA Runners NAT Gateways"
      expression  = "(http.host in {${join(" ", [for host in local.stg01_hostnames : format("\"%s\"", host)])}} and ip.src in {${local.cicd_self_hosted_runner_natgws}})"
    },
    // AI Gateway GCP Cloud NAT EIP for outbound MCP access
    {
      action      = "skip"
      description = "Allow AI Gateway GCP NAT for JC MCP and Console"
      expression  = "(http.host in {${join(" ", [for host in local.ai_gateway_gcp_nat_hostnames : format("\"%s\"", host)])}} and ip.src in {${join(" ", local.gcp_stg01_ai_gateway_nat_egress_ips)}})"
    },
    // Allow Azure Active Directory
    {
      action      = "skip"
      description = "Allow AzureActiveDirectory"
      expression  = format("(http.host eq \"api.stg01.jumpcloud.com\" and http.request.uri.path contains \"/scim/v2\" and ip.src in {%s})", join(" ", [for ip in local.azure_ad_ips : ip]))
    },
    // Allow Salesforce
    // https://help.salesforce.com/s/articleView?id=000384438&type=1
    {
      action      = "skip"
      description = "Allow Salesforce"
      expression  = format("(http.host eq \"console.stg01.jumpcloud.com\" and ip.src in {%s})", join(" ", [for ip in local.salesforce_ips : ip]))
    },
    // Allow Apple CIDR blocks for VPP Notifications in the staging environment
    {
      action      = "skip"
      description = "Allow Apple CIDR blocks for VPP Notifications"
      expression  = format("(http.host eq \"apple.mdm.stg01.jumpcloud.com\" and http.request.uri.path eq \"/vpp/notifications\" and ip.src in {%s})", join(" ", [for ip in local.apple_cidr_blocks : ip]))
    },
    {
      action      = "skip"
      description = "Allow for apple-app-site-association"
      expression  = "(http.host eq \"console.stg01.jumpcloud.com\" and http.request.uri.path eq \"/.well-known/apple-app-site-association\")"
    },
    {
      action      = "skip"
      description = "Allow Slack Stg"
      expression  = format("(http.host eq \"slack.stg01.jumpcloud.com\" and http.request.uri.path eq \"/api/slack/events\")")
    },
    {
      action      = "skip"
      description = "Allow Polaris"
      expression  = format("(http.host eq \"polaris.stg01.jumpcloud.com\")")
    },
    {
      action      = "block"
      description = "Block all traffic to Search API HTTP(s) endpoint"
      expression  = "(http.request.uri.path contains \"/api/v2/search/\" and http.host eq \"console.stg01.jumpcloud.com\" and not ip.src in {18.190.12.204 3.130.21.136 3.134.71.189})"
    },
    {
      action      = "block"
      description = "Blocking Abuse IP's"
      expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213} and http.host contains \"stg01.jumpcloud.com\")"
    },
    # {
    #   action      = "skip"
    #   description = "Allow Authorized IP's"
    #   expression  = format("(http.host in {${join(" ", local.stg01_hostnames)}} and ip.src in {%s})", join(" ", [for ip in local.stg01_ip_access : ip.ip_address if timecmp(ip.expiration, timestamp()) == 1]))
    # },
    // This block needs to be last as it will be inserted in order from top to bottom so that all skip actions will be accounted for.
    // This block is to block all traffic that is not from Zscaler
    {
      action      = "block"
      description = "Allow Zscaler Only"
      expression  = format("(http.host in $%s or http.host in $%s) and (not ip.src in {18.190.12.204 3.130.21.136 3.134.71.189} and not http.user_agent contains \"Protect Staging/\" and http.request.uri.path ne \"/google-emm/notifications\")", cloudflare_list.stg01_wildcard_hostname_list.name, cloudflare_list.stg01_nonwildcard_hostname_list.name)
    },
  ]

  managed_ruleset_overrides = [
    {
      action  = "block"
      id      = "c2a2f414a67c409f90cccb6c5bba0215"
      enabled = true
    }
  ]
}
