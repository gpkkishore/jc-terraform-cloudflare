locals {
  add_ratelimit_rules = {
    "jumpcloud.com" = [
      {
        action      = "block"
        description = "Rate Limit api/commandresults by IP - 11 Jan 2024"
        expression  = "(http.request.uri.path contains \"api/commandresults\" and ip.src in {52.77.97.81})"

        ratelimit = {
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
        action      = "skip"
        description = "Disable BIC for metadata endpoint"
        expression  = "(http.request.uri contains \"/saml2/metadata\" and http.user_agent contains \"Jakarta Commons-HttpClient/3.1\") or (http.request.uri contains \"/saml2/metadata\" and http.user_agent contains \"Java/1.8.0_322\") or (http.request.uri contains \"/saml2/metadata\" and http.user_agent contains \"Python/3.8\" and ip.src eq 18.139.27.111)"
      },
    ]
    "id.stg01.jumpcloud.com" = [
      {
        action      = "block"
        description = "Allow ZScaler only"
        expression  = "(http.host in {\"oauth.id.stg01.jumpcloud.com\" \"admin-oauth.id.stg01.jumpcloud.com\" \"trampoline.id.stg01.jumpcloud.com\"} and not ip.src in {18.190.12.204/32 3.134.71.189/32 3.130.21.136/32 3.23.44.17/32 3.23.121.107/32})"
      },
    ]
    "jumpcloud.ai" = [
      {
        action      = "block"
        description = "Block labs.stg01.jumpcloud.ai requests from non-internal IPs"
        expression  = "(not ip.src in {3.23.121.107/32 3.23.44.17/32} and http.host eq \"labs.stg01.jumpcloud.ai\")"
      },
      {
        action      = "block"
        description = "Block labs.jumpcloud.ai requests requests from non-internal IPs"
        expression  = "(not ip.src in {34.195.141.99/32 3.226.52.173/32 44.194.86.168/32} and http.host eq \"labs.jumpcloud.ai\")"
      },
    ]
  }
}
