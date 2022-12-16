module "tags" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//internal/default_tags"

  env_prefix = var.env_prefix
  managed_by = "terraform-cloudflare/tst"
  project    = "edge"
}

module "agent_s3_bucket" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/s3-bucket?ref=v6.8.5"

  env_prefix  = var.env_prefix
  bucket_name = "jumpcloud-agent-tst"
  versioning  = false
  tags        = module.tags.default_tags
}

module "mdm_s3_bucket" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/s3-bucket?ref=v6.8.5"

  env_prefix  = var.env_prefix
  bucket_name = "jumpcloud-mdm-tst"
  versioning  = false
  tags        = module.tags.default_tags
}

module "badly_named_s3_bucket" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/s3-bucket?ref=v6.8.5"

  env_prefix  = var.env_prefix
  bucket_name = "badlynamed.cloudjump.dev"
  versioning  = false
  tags        = module.tags.default_tags
}

data "cloudflare_zone" "jumpcloud_dev" {
  account_id = var.cloudflare_account_id
  name       = "cloudjump.dev"
}

# read bucket that was manually created with bucket policy set
data "aws_s3_bucket" "jc_windows_agent_mock" {
  bucket = "jc-windows-agent-mock"
}

module "cdn_new_cloudjump_dev" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/cloudfront/cdn-ng?ref=TE-132-cdn-refactor"

  env_prefix = var.env_prefix
  dns_zone   = data.cloudflare_zone.jumpcloud_dev
  cdn = {
    domain_name = "cdn-new.cloudjump.dev"
    aliases     = ["www.cdn-new.cloudjump.dev"]
    origins = [
      {
        s3_bucket                    = data.aws_s3_bucket.jc_windows_agent_mock
        cache_behavior_path_patterns = ["/production/*"]
      },
      {
        s3_bucket                    = module.agent_s3_bucket
        cache_behavior_path_patterns = ["/early-access/*"]
      },
      {
        s3_bucket                    = module.mdm_s3_bucket
        cache_behavior_path_patterns = ["/staging/*", "/testing/*"]
      }
    ]
  }
  tags = module.tags.default_tags
}

##############
# - usw2 s3 bucket
# - cdn with R53 zone

module "extras_s3_bucket_usw2" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/s3-bucket?ref=v6.8.5"

  providers = {
    aws = aws.usw2
  }

  env_prefix  = var.env_prefix
  bucket_name = "jumpcloud-extras-tst"
  versioning  = false
  tags        = module.tags.default_tags
}

#domain name is the apex of the r53 zone
module "stg_devopsconsortium_org" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/cloudfront/cdn-ng?ref=TE-132-cdn-refactor"

  env_prefix = var.env_prefix
  dns_zone   = aws_route53_zone.stg_devopsconsortium_org
  cdn = {
    domain_name = "stg.devopsconsortium.org"
    aliases     = "cdn-new.stg.devopsconsortium.org"
    origins = [
      {
        s3_bucket                    = module.extras_s3_bucket_usw2
        cache_behavior_path_patterns = ["production/*"]
      },
    ]
  }
  tags = module.tags.default_tags
}
