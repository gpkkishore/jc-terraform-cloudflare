locals {
  stg01_hostnames = [
    "jumpdesk.stg01.jumpcloud.com",
    "catalog.stg01.jumpcloud.com",
    "console.stg01.jumpcloud.com",
    "api.stg01.jumpcloud.com",
    "sso.stg01.jumpcloud.com",
    "kickstart.stg01.jumpcloud.com",
    "apple-mdm.stg01.jumpcloud.com",
    "apple.mdm.stg01.jumpcloud.com",
    "assist.stg01.jumpcloud.com",
    "microsoft-mdm.stg01.jumpcloud.com",
    "login.stg01.jumpcloud.com",
    "oauth.stg01.jumpcloud.com",
    "go.stg01.jumpcloud.com",
    "password-manager.stg01.jumpcloud.com",
    "saas.stg01.jumpcloud.com",
    "ssf.stg01.jumpcloud.com",
    "*.prd02.stg01.jumpcloud.com",
    "mcp.stg01.jumpcloud.com",
    "*.jumpdesk.stg01.jumpcloud.com",
    "*.catalog.stg01.jumpcloud.com",
    "*.console.stg01.jumpcloud.com",
    "*.api.stg01.jumpcloud.com",
    "*.sso.stg01.jumpcloud.com",
    "*.kickstart.stg01.jumpcloud.com",
    "*.apple-mdm.stg01.jumpcloud.com",
    "*.apple.mdm.stg01.jumpcloud.com",
    "*.assist.stg01.jumpcloud.com",
    "*.microsoft-mdm.stg01.jumpcloud.com",
    "*.login.stg01.jumpcloud.com",
    "*.oauth.stg01.jumpcloud.com",
    "*.go.stg01.jumpcloud.com",
    "*.password-manager.stg01.jumpcloud.com",
    "*.saas.stg01.jumpcloud.com",
    "*.ssf.stg01.jumpcloud.com",
    "*.mcp.stg01.jumpcloud.com",
  ]

  prd02_hostnames = [
    "jumpdesk.prd02.stg01.jumpcloud.com",
    "catalog.prd02.stg01.jumpcloud.com",
    "console.prd02.stg01.jumpcloud.com",
    "api.prd02.stg01.jumpcloud.com",
    "sso.prd02.stg01.jumpcloud.com",
    "kickstart.prd02.stg01.jumpcloud.com",
    "apple-mdm.prd02.stg01.jumpcloud.com",
    "apple.mdm.prd02.stg01.jumpcloud.com",
    "assist.prd02.stg01.jumpcloud.com",
    "microsoft-mdm.prd02.stg01.jumpcloud.com",
    "login.prd02.stg01.jumpcloud.com",
    "oauth.prd02.stg01.jumpcloud.com",
    "go.prd02.stg01.jumpcloud.com",
    "saas.prd02.stg01.jumpcloud.com",
    "ssf.prd02.stg01.jumpcloud.com",
    "mcp.prd02.stg01.jumpcloud.com",
  ]

  stg01_ip_access = []

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
    "52.6.23.137",
    "3.81.197.84",
    "3.81.195.225",
    "52.6.150.234",
    "34.204.155.122",
    "3.210.61.129",
    "34.225.130.203",
    "3.93.87.107",
    "52.73.252.191",
    "207.254.42.50",
    "207.254.46.86",
    "207.254.50.223",
    "100.20.244.103",
    "44.225.225.32",
    "44.227.49.133",
    "35.82.102.6",
    "108.177.225.0/24",
    "159.69.76.182",
    "168.119.151.16",
    "168.119.70.62",
    "185.200.100.144",
    "195.201.242.73",
    "195.201.242.76",
    "195.201.70.205",
    "199.7.167.10",
    "20.186.82.111/32",
    "20.53.104.100/31",
    "20.53.105.145/32",
    "207.244.124.202",
    "207.244.124.203",
    "207.244.124.209",
    "207.244.124.210",
    "207.244.124.211",
    "207.244.71.232",
    "207.254.30.108",
    "207.254.54.36",
    "23.105.12.32/27",
    "23.105.164.181",
    "23.105.164.182",
    "23.105.173.143",
    "23.105.173.144",
    "23.105.173.145",
    "23.106.237.0/24",
    "23.106.34.194/32",
    "23.106.34.195/32",
    "23.106.34.196/32",
    "23.106.34.248",
    "23.106.34.249",
    "23.82.8.241",
    "51.103.4.79/32",
    "51.103.5.4/31",
    "52.177.243.142/31",
    "94.130.238.172",
    "34.216.108.82",
    "62.0.130.109"
  ]

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
    "3.21.194.220"
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

  add_ratelimit_rules = []

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
      expression  = "(http.host in {${join(" ", [for host in local.stg01_hostnames : format("\"%s\"", host)])}} and ip.src in {44.239.135.146 54.69.255.145 44.235.245.14})"
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
      expression  = "(http.host in {${join(" ", [for host in local.stg01_hostnames : format("\"%s\"", host)])}} and not ip.src in {18.190.12.204 3.130.21.136 3.134.71.189} and not http.user_agent contains \"Protect Staging/\" and http.request.uri.path ne \"/google-emm/notifications\")"
    },
  ]
}
