locals {
  # List of IP addresses to be whitelisted
  stg01_use2_natgws = join(" ", data.aws_ec2_managed_prefix_list.stg01_use2_natgws.entries[*].cidr)
  prd_use1_natgws   = join(" ", data.aws_ec2_managed_prefix_list.prd_use1_natgws.entries[*].cidr)

  us_east_1_zscaler_ngws = "52.73.14.42/32 3.219.213.81/32 44.216.132.195/32"
  us_west_2_zscaler_ngws = "35.161.74.70/32 54.245.68.23/32 52.43.62.126/32"

  us_east_1_saleseng_ngw = "52.70.132.28/32"

  # Only using dev p03 for now -- plan to migrate to proper VaultOne Dev environment post-launch
  dev_usw2_p03_ngws = "54.185.177.193/32 54.200.253.15/32 35.95.228.211/32"

  cicd_usw2_self_hosted_ngws = "44.239.135.146/32 54.69.255.145/32 44.235.245.14/32"

  vaultone_stg_usw2_natgws     = "44.226.5.239/32 54.71.114.137/32 100.20.42.195/32"
  vaultone_homolog_use1_natgws = "44.205.147.222/32 3.221.141.250/32 34.199.245.208/32"
  vaultone_prd_use1_natgws     = "34.235.10.125/32 52.0.246.11/32 107.20.185.164/32"

  vaultone_nonprod_allowed_ips = join(" ", [
    local.us_east_1_zscaler_ngws,
    local.us_west_2_zscaler_ngws,
    local.dev_usw2_p03_ngws,
    local.vaultone_stg_usw2_natgws,
    local.stg01_use2_natgws,
    local.prd_use1_natgws,
    local.vaultone_homolog_use1_natgws,
    local.vaultone_prd_use1_natgws,
    local.us_east_1_saleseng_ngw,
  ])

  add_ratelimit_rules = {
    "jumpcloud.com" = [
      {
        action      = "block"
        description = "Rate Limit api/commandresults by IP - 11 Jan 2024"
        expression  = "(http.request.uri.path contains \"api/commandresults\" and ip.src in {52.77.97.81})"

        ratelimit = {
          counting_expression = null
          characteristics     = ["cf.colo.id", "ip.src"]
          period              = 60
          requests_per_period = 20
          mitigation_timeout  = 0
        }
      },
      {
        action      = "block"
        description = "Rate Limit api/commandresults by IP - 25 May 2023"
        expression  = "(http.request.uri.path contains \"api/commandresults\" and ip.src in {34.226.132.221 52.54.43.157})"

        ratelimit = {
          characteristics     = ["cf.colo.id", "ip.src"]
          period              = 10
          requests_per_period = 100
          mitigation_timeout  = 10
        }
      },
      {
        action      = "block"
        description = "Rate Limit api/commandresults by IP - 27 Mar 2024"
        expression  = "(http.request.uri.path contains \"api/commandresults\" and ip.src in {186.193.232.31 191.243.208.231})"

        ratelimit = {
          characteristics     = ["cf.colo.id", "ip.src"]
          period              = 10
          requests_per_period = 50
          mitigation_timeout  = 10
        }
      },
      {
        action      = "block"
        description = "Per IP rate limit on routes containing /api/systems"
        expression  = "(http.request.uri.path contains \"/api/systems\" and http.request.method eq \"PUT\")"

        ratelimit = {
          characteristics     = ["cf.colo.id", "ip.src"]
          period              = 60
          requests_per_period = 1000
          mitigation_timeout  = 60
        }
      },
      {
        action      = "block"
        description = "Admin Auth Request Rate Limit - ir-124"
        expression  = "(http.request.uri.path eq \"/auth\" and http.host eq \"console.jumpcloud.com\" and http.request.method eq \"POST\" and not http.user_agent contains \"Datadog\")"

        ratelimit = {
          characteristics     = ["cf.colo.id", "ip.src"]
          period              = 120
          requests_per_period = 10
          mitigation_timeout  = 300
        }
      },
      {
        action      = "block"
        description = "Admin Auth Request Rate Limit - ir-124 - EU"
        expression  = "(http.request.uri.path eq \"/auth\" and http.host eq \"console.eu.jumpcloud.com\" and http.request.method eq \"POST\" and not http.user_agent contains \"Datadog\")"

        ratelimit = {
          characteristics     = ["cf.colo.id", "ip.src"]
          period              = 120
          requests_per_period = 10
          mitigation_timeout  = 300
        }
      },
      {
        action      = "block"
        description = "WAF Attack"
        expression  = "(cf.waf.score lt 5)"

        ratelimit = {
          characteristics     = ["cf.colo.id", "ip.src", ]
          counting_expression = "(http.response.code eq 521)"
          mitigation_timeout  = 600
          period              = 10
          requests_per_period = 100
          requests_to_origin  = false
        },
      }
    ]
  }

  add_waf_rules = {
    "jumpcloud.com" = [
      {
        action      = "block"
        description = "Allow ZScaler only"
        expression  = "(http.host in {\"jumpdesk.jumpcloud.com\" \"dev.jumpcloud.com\"} and not ip.src in {54.187.222.118 54.218.209.46 35.165.242.218 54.86.134.208 54.86.96.53 54.86.131.111 52.70.132.28 52.43.62.126 54.245.68.23 35.161.74.70 52.73.14.42 3.219.213.81 44.216.132.195})"
      },
      {
        action      = "block"
        description = "Allow ZScaler only - EU"
        expression  = "(http.host in {\"jumpdesk.eu.jumpcloud.com\"} and not ip.src in {54.187.222.118 54.218.209.46 35.165.242.218 54.86.134.208 54.86.96.53 54.86.131.111 52.70.132.28 52.43.62.126 54.245.68.23 35.161.74.70 52.73.14.42 3.219.213.81 44.216.132.195 3.79.78.24 52.57.217.97})"
      },
      {
        action      = "block"
        description = "20240513-jccom-outage"
        expression  = "(ip.geoip.asnum eq 45102 and http.host eq \"jumpcloud.com\" and http.request.uri.path eq \"/careers\")"
      },
      {
        action      = "managed_challenge"
        description = "Managed Captcha Abuse IP's 20241224-haproxy"
        expression  = "(ip.src in {52.13.24.213 34.208.1.174 44.245.128.2 44.244.196.227 3.211.203.108 44.237.194.38 54.69.0.153 44.235.57.22})"
      },
      {
        action      = "block"
        description = "Blocking Abuse IP's"
        expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213 80.94.93.220} and http.host contains \"jumpcloud.com\")"
      }
    ]
    "id.jumpcloud.com" = [
      {
        action      = "block"
        description = "Blocking Abuse IP's"
        expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213} and http.host contains \"id.jumpcloud.com\")"
      }
    ]
    "id.stg01.jumpcloud.com" = [
      // Allow Salesforce
      // https://help.salesforce.com/s/articleView?id=000384438&type=1
      {
        action      = "skip"
        description = "Allow Salesforce"
        expression  = "(http.host eq \"admin-oauth.id.stg01.jumpcloud.com\" and ip.src in {3.146.43.224/28 13.56.32.176/28 13.58.135.64/28 13.108.0.0/14 34.211.108.32/28 34.226.36.48/28 35.182.14.32/28 66.231.80.0/20 68.232.192.0/20 96.43.144.0/20 128.17.0.0/16 128.245.0.0/16 136.146.0.0/15 198.245.80.0/20 199.122.120.0/21 204.14.232.0/21 3.225.151.145 3.225.240.254/32 18.204.28.162/32 18.211.105.61 34.197.58.108 34.204.111.166/32 52.3.16.30 52.22.251.194 52.70.135.185 155.226.0.0/16})"
      },
      {
        action      = "block"
        description = "Allow ZScaler only"
        expression  = "(http.host in {\"oauth.id.stg01.jumpcloud.com\" \"admin-oauth.id.stg01.jumpcloud.com\" \"trampoline.id.stg01.jumpcloud.com\"} and not ip.src in {18.190.12.204/32 3.134.71.189/32 3.130.21.136/32 3.23.44.17/32 3.23.121.107/32 ${local.stg01_use2_natgws} ${local.vaultone_stg_usw2_natgws} ${local.vaultone_homolog_use1_natgws} ${local.cicd_usw2_self_hosted_ngws}})"
      },
    ]
    "jumpcloud.ai" = [
      {
        action      = "block"
        description = "Block labs.stg01.jumpcloud.ai requests from non-internal IPs"
        expression  = "(not ip.src in {3.23.121.107/32 3.23.44.17/32 ${local.stg01_use2_natgws}} and http.host eq \"labs.stg01.jumpcloud.ai\")"
      },
      {
        action      = "block"
        description = "Block labs.jumpcloud.ai requests requests from non-internal IPs"
        expression  = "(not ip.src in {34.226.229.192/32 98.83.55.86/32 34.195.141.99/32 3.226.52.173/32 44.194.86.168/32} and http.host eq \"labs.jumpcloud.ai\")"
      },
      {
        action      = "block"
        description = "IR-DDoS-attempts-9 Jan 2025"
        expression  = "(ip.src eq 152.58.18.201)"
      },
      {
        action      = "block"
        description = "Blocking Abuse IP's"
        expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213} and http.host contains \"jumpcloud.ai\")"
      }
    ]
    "vault.jumpcloud.com" = [
      {
        action      = "skip"
        description = "Allow vault.jumpcloud assets (404 page, etc.)"
        expression  = "(http.host eq \"vault.jumpcloud.com\" and starts_with(http.request.uri.path, \"/assets\"))"
      },
      {
        action      = "block"
        description = "Allow ZScaler only in non-prod environments"
        expression  = "((http.host eq \"dev.vault.jumpcloud.com\" or http.host contains \"dev.vault.jumpcloud.com\") or (http.host eq \"stg.vault.jumpcloud.com\" or http.host contains \"stg.vault.jumpcloud.com\") or (http.host eq \"homolog.vault.jumpcloud.com\" or http.host contains \"homolog.vault.jumpcloud.com\") or (http.host eq \"vault.jumpcloud.com\" or http.host eq \"api.vault.jumpcloud.com\" or http.host eq \"app.vault.jumpcloud.com\")) and not ip.src in {${local.vaultone_nonprod_allowed_ips}}"
      },
      {
        action      = "block"
        description = "Blocking Abuse IP's"
        expression  = "(ip.src in {183.83.227.182 183.83.226.136 144.91.66.213} and http.host contains \"jumpcloud.com\")"
      }
    ]
  }
}

data "aws_ec2_managed_prefix_list" "stg01_use2_natgws" {
  name = "stg01-use2-natgws"
}

data "aws_ec2_managed_prefix_list" "prd_use1_natgws" {
  name = "prd-use1-natgws"
}
