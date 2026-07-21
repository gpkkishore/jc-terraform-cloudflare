####################################################
# Marketing Lightsail origin — marketing-internal.jcplatform.dev
#
# Child zone (NS glue in internal.tf). Public apex alias A → Lightsail ELB so
# CloudFront can resolve origin TLS hostname (JC-LoadBalancer-Prod-3 cert).

# ELB target matches terraform-cloudflare/prd/data_prd.tf Marketing website block.
####################################################

locals {
  marketing_internal_zone_name = "marketing-internal.jcplatform.dev"

  # data_prd.tf — live @/www proxied CNAME → this ELB
  marketing_lightsail_elb_hostname = "d3d61011c209cf0c2b83e5959e49829c-330411615.us-east-1.elb.amazonaws.com"

  # Application/Classic Load Balancer hosted zone ID (us-east-1).
  marketing_lightsail_elb_route53_zone_id = "Z35SXDOTRQ7X7K"
}

data "aws_route53_zone" "marketing_internal_jcplatform_dev" {
  name = local.marketing_internal_zone_name
}

resource "aws_route53_record" "marketing_internal_jcplatform_dev_apex_elb_alias" {
  zone_id = data.aws_route53_zone.marketing_internal_jcplatform_dev.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = "dualstack.${local.marketing_lightsail_elb_hostname}"
    zone_id                = local.marketing_lightsail_elb_route53_zone_id
    evaluate_target_health = false
  }
}
