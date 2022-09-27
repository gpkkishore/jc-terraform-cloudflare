module "prd_edge_lambda_s3" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/s3-bucket?ref=v6.1.6"

  providers = {
    aws = aws.usw2
  }

  bucket_name         = "edge-lambda-cloudflare-secret-rotation"
  versioning          = false
  env_prefix          = var.env_prefix
  tags                = merge(module.tags.default_tags, { "Project" = "Edge Lambda" })
  block_public_acls   = true
  block_public_policy = true
}
