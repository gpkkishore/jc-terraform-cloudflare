data "aws_secretsmanager_secret" "stg01_aop_ca_private_key_secret" {
  count = var.regenerate_cloudflare_mtls_ca ? 0 : 1
  name  = format("%s/cloudflare_mtls_ca_private_key", var.env)
}

data "aws_secretsmanager_secret_version" "stg01_aop_ca_private_key_secret_existing" {
  count     = var.regenerate_cloudflare_mtls_ca ? 0 : 1
  secret_id = data.aws_secretsmanager_secret.stg01_aop_ca_private_key_secret[0].id
}

resource "null_resource" "generate_private_key" {
  count = var.regenerate_cloudflare_mtls_ca ? 1 : 0
  provisioner "local-exec" {
    command = "openssl genpkey -algorithm RSA -out ${path.module}/private_key.pem -pkeyopt rsa_keygen_bits:4096"
  }
}

data "local_sensitive_file" "private_key" {
  count      = var.regenerate_cloudflare_mtls_ca ? 1 : 0
  filename   = "${path.module}/private_key.pem"
  depends_on = [null_resource.generate_private_key]
}

locals {
  private_key = var.regenerate_cloudflare_mtls_ca ? data.local_sensitive_file.private_key[0].content : data.aws_secretsmanager_secret_version.stg01_aop_ca_private_key_secret_existing[0].secret_string
}

resource "tls_self_signed_cert" "stg01_aop_ca" {
  private_key_pem       = local.private_key
  validity_period_hours = 87600 # 10 years
  subject {
    common_name = "stg01-aop-ca"
  }
  allowed_uses = [
    "cert_signing",
    "crl_signing",
    "key_encipherment",
    "digital_signature"
  ]
  is_ca_certificate = true
}

resource "aws_secretsmanager_secret" "stg01_aop_ca_secret" {
  name        = format("%s/cloudflare_mtls_ca_cert", var.env)
  description = "stg01 AOP CA certificate"
}

resource "aws_secretsmanager_secret_version" "stg01_aop_ca_secret_version" {
  secret_id     = aws_secretsmanager_secret.stg01_aop_ca_secret.id
  secret_string = tls_self_signed_cert.stg01_aop_ca.cert_pem
}

resource "cloudflare_authenticated_origin_pulls_certificate" "stg01_aop_ca" {
  zone_id     = cloudflare_zone.cloudflare_zone_resource.id
  private_key = local.private_key
  certificate = tls_self_signed_cert.stg01_aop_ca.cert_pem
  type        = "per-hostname"
}

resource "cloudflare_authenticated_origin_pulls" "aop_mtls_stg01_jumpcloud_com" {
  zone_id                                = cloudflare_zone.cloudflare_zone_resource.id
  authenticated_origin_pulls_certificate = cloudflare_authenticated_origin_pulls_certificate.stg01_aop_ca.id
  enabled                                = true
  hostname                               = "mtls.stg01.jumpcloud.com"
}
