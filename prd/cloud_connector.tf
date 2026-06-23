locals {
  help_center_v2_path_rewrite = "regex_replace(http.request.uri.path, r\"^/v2/support/?(.*)$\", r\"/$${1}\")"
}

resource "cloudflare_ruleset" "help_center_v2_path_rewrite" {
  zone_id     = cloudflare_zone.cloudflare_zone_resource.id
  name        = "JC help center v2 path rewrite"
  description = "Strip /v2/support prefix before S3 Cloud Connector routing"
  kind        = "zone"
  phase       = "http_request_transform"

  rules {
    ref         = "help_center_v2_strip_prefix"
    description = "JC help center v2 path rewrite"
    enabled     = true
    expression  = "(http.host in {\"jumpcloud.com\" \"www.jumpcloud.com\"} and http.request.uri.path matches \"^/v2/support(/.*)?$\")"
    action      = "rewrite"

    action_parameters {
      uri {
        path {
          expression = local.help_center_v2_path_rewrite
        }
      }
    }
  }
}

resource "cloudflare_cloud_connector_rules" "jumpcloud_com" {
  zone_id = cloudflare_zone.cloudflare_zone_resource.id

  rules {
    description = "JC help center v2"
    enabled     = true
    expression  = "(http.host in {\"jumpcloud.com\" \"www.jumpcloud.com\"} and http.request.uri.path matches \"^/v2/support(/.*)?$\")"
    provider    = "aws_s3"

    parameters {
      host = "jumpcloud-help-center-docs.s3-website.eu-north-1.amazonaws.com"
    }
  }
}
