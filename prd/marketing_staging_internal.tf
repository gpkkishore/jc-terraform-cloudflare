# marketing-staging-internal.jcplatform.dev — staging WordPress origin behind Lightsail LB.
#
# PR chain step 3 — requires infra-edge-marketing-website applied (remote state exists).

data "terraform_remote_state" "marketing_website" {
  backend = "s3"

  config = {
    bucket = "jumpcloud-prd-terraform-state"
    key    = "infra-edge-marketing-website/terraform.tfstate"
    region = "us-east-2"
  }
}

locals {
  marketing_staging_internal_zone_suffix = ".jcplatform.dev"

  marketing_staging_internal_cert_validation_records = try(
    data.terraform_remote_state.marketing_website.outputs.marketing_staging_cert_validation_records,
    [],
  )

  marketing_staging_internal_cert_validation_record_names = {
    for record in local.marketing_staging_internal_cert_validation_records :
    trimsuffix(trimsuffix(record.name, "."), local.marketing_staging_internal_zone_suffix) => record
  }

  marketing_staging_internal_lb_dns_name = try(
    data.terraform_remote_state.marketing_website.outputs.marketing_staging_lb_dns_name,
    "",
  )
}

resource "aws_route53_record" "marketing_staging_internal_cert_validation" {
  for_each = local.marketing_staging_internal_cert_validation_record_names

  zone_id = aws_route53_zone.jc_internal_zone.zone_id
  name    = each.key
  type    = each.value.type
  ttl     = 300
  records = [each.value.value]
}

resource "aws_route53_record" "marketing_staging_internal_alias" {
  count = local.marketing_staging_internal_lb_dns_name != "" ? 1 : 0

  zone_id = aws_route53_zone.jc_internal_zone.zone_id
  name    = "marketing-staging-internal"
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.marketing_website.outputs.marketing_staging_lb_dns_name
    zone_id                = data.terraform_remote_state.marketing_website.outputs.marketing_staging_lb_hosted_zone_id
    evaluate_target_health = false
  }
}
