module "prd_edge_lambda_s3" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/s3-bucket?ref=v6.1.6"

  env_prefix          = var.env_prefix
  bucket_name         = "prd-edge-lambda-cloudflare-secret-rotation"
  versioning          = false
  tags                = merge({ Environment = var.env_prefix }, { "Project" = "Edge Secrets Rotation Lambda" })
  block_public_acls   = true
  block_public_policy = true
}
