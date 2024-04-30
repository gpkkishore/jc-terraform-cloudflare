locals {
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
      expression  = "(http.host eq \"api.stg01.jumpcloud.com\" and http.request.uri.path eq \"/partners/v1/crowdstrike\" and http.user_agent eq \"Go-http-client/2.0\" and ip.src in {13.52.148.107 52.52.20.134 52.43.192.139 54.187.226.134 35.160.117.193 18.195.129.87 3.73.169.253 18.158.141.230})"
    },
    {
      action      = "skip"
      description = "Allow Mac Stadium"
      expression  = "(ip.src eq 207.254.33.124)"
    },
    {
      action      = "skip"
      description = "Allow TestIM"
      expression  = "(http.host eq \"console.stg01.jumpcloud.com\" and ip.src in {52.6.23.137 3.81.197.84 3.81.195.225 52.6.150.234 34.204.155.122 3.210.61.129 34.225.130.203 3.93.87.107 52.73.252.191 207.254.42.50 207.254.46.86 207.254.50.223 100.20.244.103 44.225.225.32 44.227.49.133 35.82.102.6 108.177.225.0/24 159.69.76.182 168.119.151.16 168.119.70.62 185.200.100.144 195.201.242.73 195.201.242.76 195.201.70.205 199.7.167.10 20.186.82.111/32 20.53.104.100/31 20.53.105.145/32 207.244.124.202 207.244.124.203 207.244.124.209 207.244.124.210 207.244.124.211 207.244.71.232 207.254.30.108 207.254.54.36 23.105.12.32/27 23.105.164.181 23.105.164.182 23.105.173.143 23.105.173.144 23.105.173.145 23.106.237.0/24 23.106.34.194/32 23.106.34.195/32 23.106.34.196/32 23.106.34.248 23.106.34.249 23.82.8.241 51.103.4.79/32 51.103.5.4/31 52.177.243.142/31 94.130.238.172 34.216.108.82 62.0.130.109})"
    },
    {
      action      = "skip"
      description = "Tritium/Aluminium Internal Devices IP Skip"
      expression  = "(ip.src in {70.57.27.50 66.222.117.111 66.186.219.238 66.186.212.168 75.166.167.57 97.81.234.223})"
    },
    // skip action for allowing aws vpcs for stg01.jumpcloud.com
    {
      action      = "skip"
      description = "Allow AWS VPCs"
      expression  = "(http.host in {\"jumpdesk.stg01.jumpcloud.com\" \"console.stg01.jumpcloud.com\" \"api.stg01.jumpcloud.com\" \"sso.stg01.jumpcloud.com\" \"kickstart.stg01.jumpcloud.com\" \"apple-mdm.stg01.jumpcloud.com\" \"apple.mdm.stg01.jumpcloud.com\" \"assist.stg01.jumpcloud.com\" \"microsoft-mdm.stg01.jumpcloud.com\" \"login.stg01.jumpcloud.com\" \"oauth.stg01.jumpcloud.com\" \"go.stg01.jumpcloud.com\"} and not http.user_agent contains \"Protect Staging/\" and ip.src in {18.218.84.91 18.223.127.56 3.12.61.92 3.132.240.8 3.23.121.107 3.23.44.17} and http.request.uri.path ne \"/google-emm/notifications\")"
    },
    // Allow GHA runners nat gateways
    {
      action      = "skip"
      description = "Allow GHA Runners NAT Gateways"
      expression  = "(http.host in {\"jumpdesk.stg01.jumpcloud.com\" \"console.stg01.jumpcloud.com\" \"api.stg01.jumpcloud.com\" \"sso.stg01.jumpcloud.com\" \"kickstart.stg01.jumpcloud.com\" \"apple-mdm.stg01.jumpcloud.com\" \"apple.mdm.stg01.jumpcloud.com\" \"assist.stg01.jumpcloud.com\" \"microsoft-mdm.stg01.jumpcloud.com\" \"login.stg01.jumpcloud.com\" \"oauth.stg01.jumpcloud.com\" \"go.stg01.jumpcloud.com\"} and ip.src in {44.239.135.146 54.69.255.145 44.235.245.14})"
    },
    // Allow Azure Active Directory
    {
      action      = "skip"
      description = "Allow AzureActiveDirectory"
      expression  = format("(http.host eq \"api.stg01.jumpcloud.com\" and http.request.uri.path contains \"/scim/v2\" and ip.src in {%s})", join(" ", [for ip in local.azure_ad_ips : ip]))
    },
    {
      action      = "skip"
      description = "Allow Authorized IP's"
      expression  = format("(http.host in {\"jumpdesk.stg01.jumpcloud.com\" \"console.stg01.jumpcloud.com\" \"api.stg01.jumpcloud.com\" \"sso.stg01.jumpcloud.com\" \"kickstart.stg01.jumpcloud.com\" \"apple-mdm.stg01.jumpcloud.com\" \"apple.mdm.stg01.jumpcloud.com\" \"assist.stg01.jumpcloud.com\" \"microsoft-mdm.stg01.jumpcloud.com\" \"login.stg01.jumpcloud.com\" \"oauth.stg01.jumpcloud.com\" \"go.stg01.jumpcloud.com\"} and ip.src in {%s})", join(" ", [for ip in local.stg01_ip_access : ip.ip_address if timecmp(ip.expiration, timestamp()) == 1]))
    },
    // This block needs to be last as it will be inserted in order from top to bottom so that all skip actions will be accounted for.
    // This block is to block all traffic that is not from Zscaler
    {
      action      = "block"
      description = "Allow Zscaler Only"
      expression  = "(http.host in {\"jumpdesk.stg01.jumpcloud.com\" \"catalog.stg01.jumpcloud.com\" \"console.stg01.jumpcloud.com\" \"api.stg01.jumpcloud.com\" \"sso.stg01.jumpcloud.com\" \"kickstart.stg01.jumpcloud.com\" \"apple-mdm.stg01.jumpcloud.com\" \"apple.mdm.stg01.jumpcloud.com\" \"assist.stg01.jumpcloud.com\" \"microsoft-mdm.stg01.jumpcloud.com\" \"login.stg01.jumpcloud.com\" \"oauth.stg01.jumpcloud.com\" \"go.stg01.jumpcloud.com\"} and not ip.src in {18.190.12.204 3.130.21.136 3.134.71.189} and not http.user_agent contains \"Protect Staging/\" and http.request.uri.path ne \"/google-emm/notifications\")"
    }
  ]
  stg01_ip_access = [
    {
      ip_address = "2601:280:c77f:95b0:3162:72e9:2ab5:655e"
      ticket     = "TE-807"
      expiration = "2024-05-02T00:00:00Z"
    },
    {
      ip_address = "2601:280:c77f:95b0:e44a:f839:8b9c:613b"
      ticket     = "TE-807"
      expiration = "2024-05-02T00:00:00Z"
    },
    {
      ip_address = "103.24.87.131"
      ticket     = "TE-804"
      expiration = "2024-05-04T00:00:00Z"
    },
    {
      ip_address = "fd39:ff5a:b151:4b3b:140b:83a2:932d:7ac1"
      ticket     = "TE-808"
      expiration = "2024-05-02T00:00:00Z"
    },
    {
      ip_address = "66.69.38.86"
      ticket     = "TE-808"
      expiration = "2024-05-02T00:00:00Z"
    }    
]
}

