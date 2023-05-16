# date is to indicate when the ksk was rotated
module "tst_devopsconsortium_org_ksk_05162023" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/kms/kms_key?ref=v6.11.4"

  name                     = "tst-devopsconsortium-org-ksk-05162023"
  customer_master_key_spec = "ECC_NIST_P256"
  key_usage                = "SIGN_VERIFY"
  enable_dnssec_policy     = true
  enable_key_rotation      = false # Automatic key rotation not supported for asymmetric KMS keys ie ECC
  deletion_window_in_days  = 7
  tags                     = { Environment = var.env_prefix }
}

resource "aws_route53_key_signing_key" "tst_devopsconsortium_org_05162023" {
  name                       = local.r53_tst_devopsconsortium_org
  hosted_zone_id             = aws_route53_zone.tst_devopsconsortium_org.id
  key_management_service_arn = module.tst_devopsconsortium_kms_for_ksk_05162023.arn
}

