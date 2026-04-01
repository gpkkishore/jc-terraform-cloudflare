locals {

  # This is a list of new zones to create in CF - this is only required for zones that should be managed by TF that don't have their
  # own workspace in this repo (i.e, not jumpcloud.com, stg01.jumpcloud.com, and cloudjump.dev)
  # NOTE: Every zone in this array gets assigned an enterprise license, don't use it for testing!
  cloudflare_zones = concat([
    "id.jumpcloud.com",
    "id.stg01.jumpcloud.com",
    "jumpcloudlounge.com",
    "zercurity.com",
    "jumpcloud.ai",
    "stackidentity.com",
    "vault.jumpcloud.com",
    "vault.eu.jumpcloud.com",
    "vault.in.jumpcloud.com",
  ], local.resmo_zones[*].name)

  ###########################################
  # Vault
  ###########################################
  vault_records = [
    # Dev environment
    {
      name    = "connect.dev.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-41.awsdns-05.com."
    },
    {
      name    = "connect.dev.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1550.awsdns-01.co.uk."
    },
    {
      name    = "connect.dev.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-808.awsdns-37.net."
    },
    {
      name    = "connect.dev.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1256.awsdns-29.org."
    },
    {
      name    = "grpc.dev.vault.jumpcloud.com",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "internal-vaultone-dev-grpc-internal-1844655128.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "*.app.dev.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-dev-shared-public-alb-545851518.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "*.api.dev.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-dev-shared-public-alb-545851518.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "*.ws.dev.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-dev-shared-public-alb-545851518.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "app.dev.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-dev-shared-public-alb-545851518.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "api.dev.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-dev-shared-public-alb-545851518.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "ws.dev.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-dev-shared-public-alb-545851518.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "dev.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d357i8njl4hvc1.cloudfront.net"
    },
    {
      name    = "*.dev.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d357i8njl4hvc1.cloudfront.net"
    },
    {
      name    = "_d27239f91af7dcbe19bd8508a911d0fb.dev.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_dd6ba4ccac91674dbd7ff913cf8ceebf.xlfgrmvvlj.acm-validations.aws."
    },
    {
      name    = "_152afca5ed2cd9af9c3edd78cd712160.api.dev.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_f5bb8a6dac603e7ff5d2d30b85164537.xlfgrmvvlj.acm-validations.aws."
    },
    {
      name    = "_a5e57a291c89b8dc3238293db095d812.app.dev.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_a7f0ad4c1052eb75a9b3c2c8d5889b46.xlfgrmvvlj.acm-validations.aws."
    },
    {
      name    = "_238cf60eaffedeca6c2687f102c64be0.ws.dev.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_c9632f8dd199801c6e631a55a568c2ae.jkddzztszm.acm-validations.aws."
    },
    # Staging environment
    {
      name    = "connect.stg.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1504.awsdns-60.org."
    },
    {
      name    = "connect.stg.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1960.awsdns-53.co.uk."
    },
    {
      name    = "connect.stg.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-528.awsdns-02.net."
    },
    {
      name    = "connect.stg.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-481.awsdns-60.com."
    },
    {
      name    = "*.app.stg.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-stg-shared-public-alb-1164184271.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "*.api.stg.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-stg-shared-public-alb-1164184271.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "*.ws.stg.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-stg-shared-public-alb-1164184271.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "app.stg.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-stg-shared-public-alb-1164184271.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "api.stg.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-stg-shared-public-alb-1164184271.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "ws.stg.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-stg-shared-public-alb-1164184271.us-west-2.elb.amazonaws.com"
    },
    {
      name    = "stg.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d2z9kedgo3d1n6.cloudfront.net"
    },
    {
      name    = "*.stg.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d2z9kedgo3d1n6.cloudfront.net"
    },
    {
      name    = "_359cd8aa33ba139b1a5b72ab18df62e7.stg.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_78cfc067dc2c92cd241ad983a5b9cc34.xlfgrmvvlj.acm-validations.aws."
    },
    {
      name    = "_f28d9e692ad7c43ef2e4fb1b06e0831a.api.stg.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_1dd11ea228b886030be225cbbc808cd6.xlfgrmvvlj.acm-validations.aws."
    },
    {
      name    = "_1c0580639cb8f8a3388bcc5447eb1c91.app.stg.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_030a77ddc76e99a65c51294b9f04ebad.xlfgrmvvlj.acm-validations.aws."
    },
    # Homolog environment
    {
      name    = "connect.homolog.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1427.awsdns-50.org."
    },
    {
      name    = "connect.homolog.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1888.awsdns-44.co.uk."
    },
    {
      name    = "connect.homolog.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-808.awsdns-37.net."
    },
    {
      name    = "connect.homolog.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-206.awsdns-25.com."
    },
    {
      name    = "grpc.homolog.vault.jumpcloud.com",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "internal-vaultone-homolog-grpc-internal-210913626.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "*.app.homolog.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-homolog-alb-2078342682.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "*.api.homolog.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-homolog-alb-2078342682.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "*.ws.homolog.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-homolog-alb-2078342682.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "app.homolog.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-homolog-alb-2078342682.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "api.homolog.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-homolog-alb-2078342682.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "ws.homolog.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-homolog-alb-2078342682.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "homolog.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d2w91hk1xwxym1.cloudfront.net"
    },
    {
      name    = "*.homolog.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d2w91hk1xwxym1.cloudfront.net"
    },
    {
      name    = "_8e549b61c5e94f9d21c230960fce68f2.homolog.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_97d82db4dc06b5e9857cbd11fcb57931.xlfgrmvvlj.acm-validations.aws."
    },
    {
      name    = "_fb2ff7c5ecd57886e1ec244942d6fecb.app.homolog.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_cc33ebee06c8b8f985cebb4ddf82ddda.xlfgrmvvlj.acm-validations.aws."
    },
    {
      name    = "_8c28f45140c7eb1abbbd825e8f7e2555.api.homolog.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_336b6d11494b2ef7eea10bd0f146ed6a.xlfgrmvvlj.acm-validations.aws."
    },
    # Prod environment
    {
      name    = "connect.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-727.awsdns-26.net."
    },
    {
      name    = "connect.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-123.awsdns-15.com."
    },
    {
      name    = "connect.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1034.awsdns-01.org."
    },
    {
      name    = "connect.vault.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1839.awsdns-37.co.uk."
    },
    {
      name    = "grpc.vault.jumpcloud.com",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "internal-vaultone-prd-grpc-internal-353130988.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "*.app.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "*.api.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "*.ws.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "app.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "api.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "ws.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd-shared-public-alb-186363599.us-east-1.elb.amazonaws.com"
    },
    {
      name    = "vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d1iz1fyeo9jhbg.cloudfront.net"
    },
    {
      name    = "*.vault.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d1iz1fyeo9jhbg.cloudfront.net"
    },
    {
      name    = "_86ccc194fb9a107e2f3143de2e40e233.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_9f3f3821313d57a63cf4ddb36394bb26.xlfgrmvvlj.acm-validations.aws."
    },
    {
      name    = "_967813379798eac53dff97f156b9bd89.api.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_699a235b734ec43e1510581f15c92cd6.xlfgrmvvlj.acm-validations.aws."
    },
    {
      name    = "_8bc62664f1a971c631804cd436fa01b7.app.vault.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_b025dcb084aabe277bed32548caf0c59.xlfgrmvvlj.acm-validations.aws."
    },
  ]

  vault_eu_records = [
    # Prd02 environment
    {
      name    = "connect.vault.eu.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-896.awsdns-48.net."
    },
    {
      name    = "connect.vault.eu.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-14.awsdns-01.com."
    },
    {
      name    = "connect.vault.eu.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1089.awsdns-08.org."
    },
    {
      name    = "connect.vault.eu.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1954.awsdns-52.co.uk."
    },
    {
      name    = "grpc.vault.eu.jumpcloud.com",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "internal-vaultone-prd02-grpc-internal-731980982.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "*.app.vault.eu.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "*.api.vault.eu.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "app.vault.eu.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "api.vault.eu.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "*.ws.vault.eu.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "ws.vault.eu.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd02-shared-public-alb-1710404515.eu-central-1.elb.amazonaws.com"
    },
    {
      name    = "@",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d1l0uz48ej0js9.cloudfront.net"
    },
    {
      name    = "*.vault.eu.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d1l0uz48ej0js9.cloudfront.net"
    },
    {
      name    = "_3afe2dbdfbe05a8d074067bb6ef7dfda.vault.eu.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_9db7631f33fbd19e6cf173a109e5ef43.jkddzztszm.acm-validations.aws."
    },
    {
      name    = "_356d9a1a1794aedc9527c6cc09e1db16.api.vault.eu.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_027180c0995a6f6d437b5f1df507face.jkddzztszm.acm-validations.aws."
    },
    {
      name    = "_476df96d191519bac91cd822344c8d78.app.vault.eu.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_0c99d46c624a7c714394f5537bb7ae47.jkddzztszm.acm-validations.aws."
    },
  ]

  vault_in_records = [
    # Prd03 environment
    {
      name    = "connect.vault.in.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-890.awsdns-47.net."
    },
    {
      name    = "connect.vault.in.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-196.awsdns-24.com."
    },
    {
      name    = "connect.vault.in.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1081.awsdns-07.org."
    },
    {
      name    = "connect.vault.in.jumpcloud.com",
      ttl     = 300,
      proxied = false,
      type    = "NS",
      value   = "ns-1612.awsdns-09.co.uk."
    },
    {
      name    = "grpc.vault.in.jumpcloud.com",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "internal-vaultone-prd03-grpc-internal-763405070.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "*.app.vault.in.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "*.api.vault.in.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "app.vault.in.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "api.vault.in.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "*.ws.vault.in.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "ws.vault.in.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "vaultone-prd03-shared-public-alb-836542350.ap-south-1.elb.amazonaws.com"
    },
    {
      name    = "@",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d2notaopjayrxl.cloudfront.net"
    },
    {
      name    = "*.vault.in.jumpcloud.com",
      ttl     = 1,
      proxied = true,
      type    = "CNAME",
      value   = "d2notaopjayrxl.cloudfront.net"
    },
    {
      name    = "_de36f8e8d840dd449aa669abe493e7a0.vault.in.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_1b43242fe9b1b378f0080d81a59ff8d2.jkddzztszm.acm-validations.aws."
    },
    {
      name    = "_c41736bfc1e23b0d8fec5d53c25e272d.api.vault.in.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_fdf1192de86a2ad7ca8cd31e43c11832.jkddzztszm.acm-validations.aws."
    },
    {
      name    = "_925269e08a6490dc1ef143896ebdec9b.app.vault.in.jumpcloud.com.",
      ttl     = 60,
      proxied = false,
      type    = "CNAME",
      value   = "_ca94baadf6046fffe40b1ad6362d085e.jkddzztszm.acm-validations.aws."
    },
  ]

  ###########################################
  # Zercurity
  ###########################################
  zercurity_tmp_records = [
    {
      name    = "zercurity.com",
      proxied = true,
      ttl     = 1,
      type    = "CNAME",
      value   = "d6512e5frv0jf.cloudfront.net"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 1,
      ttl      = 1,
      type     = "MX",
      value    = "aspmx.l.google.com"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 5,
      ttl      = 1,
      type     = "MX",
      value    = "alt1.aspmx.l.google.com"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 5,
      ttl      = 1,
      type     = "MX",
      value    = "alt2.aspmx.l.google.com"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 10,
      ttl      = 1,
      type     = "MX",
      value    = "aspmx2.googlemail.com"
    },
    {
      name     = "zercurity.com",
      proxied  = false,
      priority = 10,
      ttl      = 1,
      type     = "MX",
      value    = "aspmx3.googlemail.com"
    },
    {
      name    = "zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "v=spf1 include:_spf.google.com include:amazonses.com ~all"
    },
    {
      name    = "_amazonses.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "oqBEcdoMWCpvqalNakfOj8IyHpeX2pDp8C4r5HwsOwc="
    },
    {
      name    = "_dmarc.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "v=DMARC1; p=quarantine; pct=20; rua=mailto:admin@zercurity.com; sp=reject; aspf=r"
    },
    {
      name    = "77bqigdckkv6gcrbehst4bpb5ymitf3v._domainkey.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "77bqigdckkv6gcrbehst4bpb5ymitf3v.dkim.amazonses.com"
    },
    {
      name    = "google._domainkey.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "TXT",
      value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCBOI5GqHDkXyPJgpy8RKx54xnqparuVM/r89h0AbVwyI/AH35xSWNtPt0o0kZjW2zhd6ULZVodSov0llFfWkttfzsXSRjZa+uIr3yKKedH9hCFy9a/67vBWK8pjGW+g2nlJfNTTRRn26DiQZcvv1bNpyooouSnZ5v1swRQPLkbDQIDAQAB"
    },
    {
      name    = "lus3623kjx5wvmcrk25fq4gsoe4h3dxe._domainkey.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "lus3623kjx5wvmcrk25fq4gsoe4h3dxe.dkim.amazonses.com"
    },
    {
      name    = "orajezzoo3b477kduh5mk4r4umcpqlpz._domainkey.zercurity.com",
      proxied = false,
      ttl     = 1,
      type    = "CNAME",
      value   = "orajezzoo3b477kduh5mk4r4umcpqlpz.dkim.amazonses.com"
    },
    {
      name    = "api.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "app.zercurity.com",
      proxied = true,
      ttl     = 1,
      type    = "CNAME",
      value   = "dcnxy99tjmi0x.cloudfront.net"
    },
    {
      name    = "atlassian-connect.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "cm1.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "data.zercurity.com",
      proxied = true,
      ttl     = 1,
      type    = "CNAME",
      value   = "dpdk4xh1u6rui.cloudfront.net"
    },
    {
      name    = "docs.zercurity.com",
      proxied = true,
      ttl     = 1,
      type    = "CNAME",
      value   = "dpdk4xh1u6rui.cloudfront.net"
    },
    {
      name    = "download.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "ecr.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "repo.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "sentry.zercurity.com",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "0.0.0.0"
    },
    {
      name    = "www.zercurity.com",
      proxied = true,
      ttl     = 1,
      type    = "CNAME",
      value   = "d2s0xzif3whxwe.cloudfront.net"
    }
  ]

  ###########################################
  # jumpcloud.ai
  ###########################################
  jumpcloud_ai_tmp_records = [
    {
      name    = "jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli.prd-use1.jcplatform.dev"
    },
    {
      name     = "jumpcloud.ai."
      proxied  = false
      ttl      = 300
      type     = "MX"
      value    = "inbound-smtp.us-west-2.amazonaws.com."
      priority = 10
    },

    {
      name    = "jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "\"v=spf1 include:amazonses.com ~all\""
    },
    {
      name    = "_6118e8f680ff20142507a919f01f02f2.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "_54c0ce4eff1b5c1d64535548f6532a91.nrbkhpnbdq.acm-validations.aws."
    },
    {
      name    = "_amazonses.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "\"tZG3EExPo9JuOKS7z9FyzjOrdo09J4SiwP9GXiskwlU=\""
    },
    {
      name    = "_dmarc.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "TXT"
      value   = "\"v=DMARC1;p=quarantine;pct=100;fo=1\""
    },
    # Domain Keys used for email
    {
      name    = "3p3wbyropt6azbu6ksmg4q5usw3mup2l._domainkey.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "3p3wbyropt6azbu6ksmg4q5usw3mup2l.dkim.amazonses.com."
    },
    {
      name    = "emznfl5kmth37sksl7q3sb72s25yemrp._domainkey.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "emznfl5kmth37sksl7q3sb72s25yemrp.dkim.amazonses.com."
    },
    {
      name    = "qwakdshufxtgact5zc6x3tviexz4gar4._domainkey.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "qwakdshufxtgact5zc6x3tviexz4gar4.dkim.amazonses.com."
    },
    {
      name    = "autodiscover.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "autodiscover.mail.us-west-2.awsapps.com."
    },
    {
      name    = "labs.jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "44.216.106.214"
    },
    {
      name    = "stg01.jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "nli.stg01.jumpcloud.com"
    },
    {
      name    = "labs.stg01.jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "A"
      value   = "44.216.106.214"
    },
    {
      name    = "www.jumpcloud.ai."
      proxied = true
      ttl     = 1
      type    = "CNAME"
      value   = "jumpcloud.ai"
    },
    {
      name    = "_3962e45834f0472e0e68df6299a3430d.www.jumpcloud.ai."
      proxied = false
      ttl     = 300
      type    = "CNAME"
      value   = "_dba5a7fcc698fc0d1dbd24e71013ce00.nrbkhpnbdq.acm-validations.aws."
    }
  ]

  ###########################################
  # StackIdentity
  ###########################################
  stackidentity_tmp_records = [
    {
      name    = "@",
      proxied = false,
      ttl     = 600,
      type    = "A",
      value   = "54.197.63.83"
    },
    {
      name    = "@",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "google-site-verification=GigGMaov2xNgLKVnXry-PwoP9ULiWW57vpfXg5E8Ejk"
    },
    // TXT
    {
      name    = "@",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "v=spf1  include:_spf.google.com include:spf.protection.outlook.com include:zcsend.net ~all"
    },
    {
      name    = "201034._domainkey",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDkDYZCSfJZ9pw/sATNp6QoLdcOjF0hErKiepqDgVFFRjBA12VelBbLNF7byoyWDkmF5SIPONHfI4CfWo9UGgMEfR8fUrPYvWk+3FyfJSkNx3JJDGJxg4SEm4TyB6NUokwExpbS1yeV4TRaa17GJaszNpvsJAa7qRHqyuOMLZHs1wIDAQAB"
    },
    {
      name    = "google._domainkey",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgGAA06VV/1sfK2TOTiy7gUHNadKiB+R5fexn059zij8BhXASdb6t2Pb0N5ssjjbypAhCULIE/l5NRfXF77MeQyxC/hV9iY7iSsG9DpAQ63DO575iMIKT0Yj6gs+ViAaPqZTZJRbsWhYErIDwcOEr87gb7eiA/emlCHn+tSunN3KIGuZopcug578vdZFcdyd4nyTFoDGzsLiAcTwhmlaof8UqeIvpWn6DhKO2tsWaDHkVYQNswrK90C4lAbLwggLLY4o+se8i3YjApr5ELaj5dEQMZwYq0Gs/20YrYjNxqtkR6RscEPJHxRGY2iTweQa78ABVhRab4GUYjk+NlmQeCQIDAQAB"
    },
    {
      name    = "_acme-challenge",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "i8ZT1YqybQEpFqJKDXZYgPnU8YbLQNazmNdt4anNxiw"
    },
    {
      name    = "_amazonses",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "FaEEbJq2BA2G2dwbUKzxtGsMGcorLtcTYGEIOCUU+bw="
    },
    {
      name    = "_dmarc",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "v=DMARC1; p=none; rua=mailto:postmaster@stackidentity.com; adkim=s; aspf=s"
    },
    {
      name    = "_gh-stackid-e",
      proxied = false,
      ttl     = 3600,
      type    = "TXT",
      value   = "a26e27f720"
    },
    // CNAME
    {
      name    = "autodiscover"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "autodiscover.outlook.com."
    },
    {
      name    = "enterpriseenrollment"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "enterpriseenrollment.manage.microsoft.com."
    },
    {
      name    = "enterpriseregistration"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "enterpriseregistration.windows.net."
    },
    {
      name    = "hs3zgaufq3ce7hho4rpi56uesnmaaafo._domainkey"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "hs3zgaufq3ce7hho4rpi56uesnmaaafo.dkim.amazonses.com."
    },
    {
      name    = "htskszr2d6fr5nzb4dgoyiwwctxa6wj5._domainkey"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "htskszr2d6fr5nzb4dgoyiwwctxa6wj5.dkim.amazonses.com."
    },
    {
      name    = "xfxd6vlc6fqsfejgvtppnwe27n3qubw._domainkey"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "jxfxd6vlc6fqsfejgvtppnwe27n3qubw.dkim.amazonses.com."
    },
    {
      name    = "lyncdiscover"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "webdir.online.lync.com."
    },
    {
      name    = "sip"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "sipdir.online.lync.com."
    },
    {
      name    = "www"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "stackidentity.com"
    },
    {
      name    = "_domainconnect"
      proxied = false
      ttl     = 3600
      type    = "CNAME"
      value   = "_domainconnect.gd.domaincontrol.com."
    },
    // MX
    {
      name     = "@"
      priority = 1
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "aspmx.l.google.com."
    },
    {
      name     = "@"
      priority = 10
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "alt4.aspmx.l.google.com."
    },
    {
      name     = "@"
      priority = 10
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "alt3.aspmx.l.google.com."
    },
    {
      name     = "@"
      priority = 5
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "alt1.aspmx.l.google.com."
    },
    {
      name     = "@"
      priority = 5
      proxied  = false
      ttl      = 3600
      type     = "MX"
      value    = "alt2.aspmx.l.google.com."
    },
  ]

  ###########################################
  # Resmo
  ###########################################
  resmo_zones = [
    {
      name = "resmo.com"
      dns_records = [
        # A records
        {
          name    = "resmo.com"
          proxied = true
          ttl     = 1
          type    = "A"
          value   = "75.2.70.75"
        },
        {
          name    = "resmo.com"
          proxied = true
          ttl     = 1
          type    = "A"
          value   = "99.83.190.102"
        },

        # CNAME records
        {
          # was alias A record in aws
          name    = "app"
          proxied = false
          ttl     = 60
          type    = "CNAME"
          value   = "d1b3fscmxwb4xc.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "browser"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "d1ogzvyyqrr4l5.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "id"
          proxied = false
          ttl     = 60
          type    = "CNAME"
          value   = "d1b3fscmxwb4xc.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "login"
          proxied = false
          ttl     = 60
          type    = "CNAME"
          value   = "d1b3fscmxwb4xc.cloudfront.net"
        },
        {
          # was alias A record in aws
          name    = "static"
          proxied = false
          ttl     = 60
          type    = "CNAME"
          value   = "dfbrjj3fnyucv.cloudfront.net"
        },
        {
          name    = "_680d782af04216a8b61c51bac7cc7bbc"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "_977e3564c47b7c7b216b1454a6648e87.xrchbtpdjs.acm-validations.aws."
        },
        {
          name    = "_8cfeba28edf6dad058356ccf166c98ea"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "_f58085647f4f8d452e910c8721c8cad4.mntkzmhvxg.acm-validations.aws."
        },
        {
          name    = "4u6mxursrjjt3aze3rcr5prxokcxejrs._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "4u6mxursrjjt3aze3rcr5prxokcxejrs.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "c4oloqlctkaw26sz54662idkxubnpq65._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "c4oloqlctkaw26sz54662idkxubnpq65.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "c5fgs4xwcbjrygwkc2rwnsddrivnzdom._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "c5fgs4xwcbjrygwkc2rwnsddrivnzdom.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "fchynlnz357ydlo3jwdxags2lezzgp3z._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "fchynlnz357ydlo3jwdxags2lezzgp3z.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "hs1-22352923._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "resmo-com.hs14a.dkim.hubspotemail.net."
        },
        {
          name    = "hs2-22352923._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "resmo-com.hs14b.dkim.hubspotemail.net."
        },
        {
          name    = "intercom._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "9c748959-eb77-42fd-9764-aff648a230bb.dkim.intercom.io."
        },
        {
          name    = "nghohojb7jd2zujpgk35gob7zqfnwfga._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "nghohojb7jd2zujpgk35gob7zqfnwfga.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "oecdx2ii6zt26yrrik35xttxz6ar4sqy._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "oecdx2ii6zt26yrrik35xttxz6ar4sqy.dkim.custom-email-domain.stripe.com."
        },
        {
          name    = "pd1._domainkey"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "pd1.pdrserv.com"
        },
        {
          name    = "pd2._domainkey.resmo.com"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "pd2.pdrserv.com"
        },
        {
          name    = "blog-test"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "22352923.group23.sites.hubspot.net"
        },
        {
          name    = "bounce"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "custom-email-domain.stripe.com"
        },
        {
          name    = "changelog"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "cname.announcekit.app"
        },
        {
          name    = "docs.resmo.com."
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "b3ed3db57d-hosting.gitbook.io"
        },
        {
          name    = "email-test"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "22352923.group23.sites.hubspot.net"
        },
        {
          name    = "emails"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "aplolinks.com"
        },
        {
          name    = "outbound.intercom"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "rp.resmo.intercom-mail.com"
        },
        {
          name    = "landing-test"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "22352923.group23.sites.hubspot.net"
        },
        {
          name    = "resources"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "b3ed3db57d-hosting.gitbook.io"
        },
        {
          name    = "trust"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "custom.trustpage.app"
        },
        {
          name    = "_acme-challenge.trust"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "skyk14zsti65zvrkyc.fastly-validations.com"
        },
        {
          name    = "www"
          proxied = true
          ttl     = 1
          type    = "CNAME"
          value   = "proxy-ssl.webflow.com"
        },

        # TXT Records
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "google-site-verification=ICo5Fg_M7RNVfh2XGkMuwGJh2MHgfJsHDCQ9UCb5x1s"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "atlassian-domain-verification=1sRYQtar/Fxm3JcAe4uVui38xaPxcJIKxOmp/bteFurxTJgwElFO6RKaXdWZI5Nx"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "google-site-verification=TH4-NfM4VQXiDPQg5qGrPYp884ZqpHYqij6wdfnXv84"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "stripe-verification=e21f4376ad23e3d9e89a34364cae78898d107fe720e49ece3a4043fa2a6aa47a"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=spf1 include:_spf.google.com -all"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "MS=DFFC3541DF0EBDB98D1E45852D1AF2557CE235EB"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "google-site-verification=34Bi68IcTETgPnQErlWcTjTZLuGwmWVCSiRnWLf8TmI"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "hubspot-developer-verification=M2NjNDljYmQtYmI0OS00OGUyLTk5ZmUtZjcwYzBmZmEyYjk0"
        },
        {
          name    = "_dmarc"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=DMARC1;p=none;pct=100;rua=mailto:dmarc.feedback@resmo.com;"
        },
        {
          name    = "google._domainkey"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA61Ij2n3QfT9cbc7uYPS/DAapgJ3OKKViqIl+nAtKVLslD7t1qac3+dJHHf1YMlyDWPFLQb4OTUwR58+WTmZ8MnVD7FKcrh6tHUW+4iy61WqzJYaZ33A/HIuUj1ENNihZ9BDqzei/m8zIeEVwzza/T60YlywInoLBIlIgNUDpYS0Gr3Fnd2kmNbsi9hR96cvXYXKM0tYR8q67JO1dRbWvBcTq1Tjk3C46G3HgrIaShtl0mTr2JqeWVE7qWeUOJbhAdizU2u1gL6b2RBay/qmZCGssfEYa6lU5yQiVMBFu0gw8MncXFf1yX88m9bhCun94adnskuuTaL/FzxmmDdAhPwIDAQAB"
        },
        {
          name    = "_github-challenge-resmoio-organization"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "dca392dafe"
        },
        {
          name    = "_pdcid"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "gjkZ-FMFl9DvYoZmBZBvi3Rw3NpC_9t7R2A5SZYtFdtCiuEZ"
        },
        {
          name    = "_github-challenge-resmoio-organization.www"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "6c9d0182b5"
        },

        # MX Records
        {
          name     = "@"
          priority = 1
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 5
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt1.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 5
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt2.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 10
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt3.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 10
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt4.aspmx.l.google.com"
        }
      ]
    },
    {
      name = "resmo.io"
      dns_records = [
        # A records
        {
          name    = "resmo.io"
          proxied = false
          ttl     = 300
          type    = "A"
          value   = "75.2.70.75"
        },
        {
          name    = "resmo.io"
          proxied = false
          ttl     = 300
          type    = "A"
          value   = "99.83.190.102"
        },
        {
          name    = "dev"
          proxied = false
          ttl     = 300
          type    = "A"
          value   = "127.0.0.1"
        },
        {
          name    = "052.dev"
          proxied = false
          ttl     = 300
          type    = "A"
          value   = "127.0.0.1"
        },

        #CNAME Records
        {
          # was alias A record in aws
          name    = "apis"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "dualstack.resmo-api-1826250524.us-west-2.elb.amazonaws.com"
        },
        {
          # was alias A record in aws
          name    = "lb"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "dualstack.resmo-api-1826250524.us-west-2.elb.amazonaws.com"
        },
        {
          name    = "_5e49427239f47d6873989c00feb431bb"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "_22c0c5f44b7c37145ea0d5dfd81c94cf.bbfvkzsszw.acm-validations.aws."
        },
        {
          name    = "4elayc3ht45v7lfewmqhi3jpebchvmcq._domainkey"
          proxied = false
          ttl     = 1800
          type    = "CNAME"
          value   = "4elayc3ht45v7lfewmqhi3jpebchvmcq.dkim.amazonses.com"
        },
        {
          name    = "m3kttf5jyddzw3snmrdq3ba6hkqorciv._domainkey"
          proxied = false
          ttl     = 1800
          type    = "CNAME"
          value   = "m3kttf5jyddzw3snmrdq3ba6hkqorciv.dkim.amazonses.com"
        },
        {
          name    = "xlazj5vmv7dgxjwa2wwjnjorgwliwv66._domainkey"
          proxied = false
          ttl     = 1800
          type    = "CNAME"
          value   = "xlazj5vmv7dgxjwa2wwjnjorgwliwv66.dkim.amazonses.com"
        },
        {
          name    = "app"
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "d11qqtz2abv5n8.cloudfront.net"
        },
        {
          name    = "www",
          proxied = false
          ttl     = 300
          type    = "CNAME"
          value   = "proxy-ssl.webflow.com"
        },

        # TXT Records
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "google-site-verification=iuX5A-PjgAM_36ZSOLDuH9Ts_I3euoiyxy2g_puppaQ"
        },
        {
          name    = "@"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=spf1 include:_spf.google.com -all"
        },
        {
          name    = "_amazonses"
          proxied = false
          ttl     = 1800
          type    = "TXT"
          value   = "BkjK9oKpWMsRtisrTQGhFWGswGTzydJpEBj1/DYb/z0="
        },
        {
          name    = "_dmarc"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=DMARC1;p=none;pct=100;"
        },
        {
          name    = "google._domainkey"
          proxied = false
          ttl     = 300
          type    = "TXT"
          value   = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAn3w+v/HqDBTwwPC73u6/mJLsRruoUCQ0VgJK1DUZ/GrXv20Lp4MrCRAycSrp9GtdNeRTRZjoNrNbX/nAjrIARs296MO2/hRT+AGZ6VGYnS0MVeGP1k1sHdM5iWEphximArt4JuOcwHL46H204949VOyc0Tp9IJux51JgdV3hIia4Ib36oWc8GGhlM77eNIcZ8A8xQJCjjGpY1W1cyfxATKlXPiHGds+b02Z1Pj++H4R0jcpDSheI4YyvJ5kpWeP3elTTwRgPaOQCGipaZDCw80EzGnDg4IsYWkmqeZ78u98I7DmYQhuDyHzk7EDGFYY3+ltWHYV10FNeMaq4XsxjSQIDAQAB"
        },
        # MX Records
        {
          name     = "@"
          priority = 1
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 5
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt1.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 5
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt2.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 10
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt3.aspmx.l.google.com"
        },
        {
          name     = "@"
          priority = 10
          proxied  = false
          ttl      = 300
          type     = "MX"
          value    = "alt4.aspmx.l.google.com"
        }
      ]
    },
  ]

}
