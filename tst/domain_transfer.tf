locals {
  vpc_tiers = [
    {
      azs = {
        a = {
          private = []
          public  = ["10.0.1.0/28"]
        }
      }
      name    = "app"
      network = "10.0.0.0/20"
    }
  ]
}

module "vpcs" {
  source = "git@github.com:JudeQuintana/terraform-modules.git//networking/tiered_vpc_ng?ref=v1.4.5"

  for_each = { for t in local.vpc_tiers : t.name => t }

  env_prefix       = var.env_prefix
  region_az_labels = var.region_az_labels
  tier             = each.value
}

# temporarily using intra_vpc_security group to add inbound 80 from anywhere
resource "aws_security_group_rule" "domain_transfer_inbound" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = lookup(module.vpcs, local.tiered_vpc_names.app).intra_vpc_security_group_id
}

locals {
  # ie local.tiered_vpc_names.app will be "app"
  tiered_vpc_names = { for vpc_name, this in module.vpcs : vpc_name => vpc_name }

  instances = [
    {
      # tst-app-public
      name = format("%s-%s-public", var.env_prefix, local.tiered_vpc_names.app)
      # lookup the first public subnet id that belongs to AZ 'a' in the 'app' VPC
      subnet_id = lookup(lookup(module.vpcs, local.tiered_vpc_names.app).az_to_public_subnet_ids, "a")[0]
      vpc_security_group_ids = [
        lookup(module.vpcs, local.tiered_vpc_names.app).default_security_group_id,
        lookup(module.vpcs, local.tiered_vpc_names.app).intra_vpc_security_group_id
      ]
    },
    {
      # tst-app-public-2
      name = format("%s-%s-public-2", var.env_prefix, local.tiered_vpc_names.app)
      # lookup the first public subnet id that belongs to AZ 'a' in the 'app' VPC
      subnet_id = lookup(lookup(module.vpcs, local.tiered_vpc_names.app).az_to_public_subnet_ids, "a")[0]
      vpc_security_group_ids = [
        lookup(module.vpcs, local.tiered_vpc_names.app).default_security_group_id,
        lookup(module.vpcs, local.tiered_vpc_names.app).intra_vpc_security_group_id
      ]
    }
  ]

  instance_name_to_instance = { for i in local.instances : i.name => i }
}

# EC2 instances commented out for now instead of deleting code for future DNSSEC testing (ie key rotation)
# ref: https://jumpcloud.atlassian.net/browse/TE-273
#resource "aws_instance" "domain_transfer_instances" {
#for_each = local.instance_name_to_instance

#ami                    = "ami-0dc2d3e4c0f9ebd18" # AWS Linux 2 us-east-1
#instance_type          = "t2.micro"
#key_name               = "domain-transfer-test" # manually created in us-east-1
#subnet_id              = each.value.subnet_id
#vpc_security_group_ids = each.value.vpc_security_group_ids
#user_data              = <<EOF
##!/bin/bash
#sudo hostname ${each.value.name}
#sudo yum update -y
#sudo amazon-linux-extras install nginx1
#echo "hello world" | sudo tee /usr/share/nginx/html/index.html
#sudo systemctl enable nginx
#sudo systemctl start nginx
#EOF
#tags = {
#Name = each.value.name
#}
#}

# EIPs commented out for now instead of deleting code for future DNSSEC testing (ie key rotation)
# ref: https://jumpcloud.atlassian.net/browse/TE-273
# each ec2 instance will get an EIP
#resource "aws_eip" "domain_transfer_instances" {
#for_each = local.instance_name_to_instance

#vpc      = true
#instance = lookup(aws_instance.domain_transfer_instances, each.key).id
#}


locals {
  domain_transfer_cloudflare_zone                       = "devopsconsortium.org"
  domain_transfer_r53_stg_devops_consortium_org_subzone = format("%s.%s", "stg", local.domain_transfer_cloudflare_zone)
  cloudlare_agent_devopsconsortium_org                  = format("%s.%s", "agent", local.domain_transfer_cloudflare_zone)
  r53_tst_devopsconsortium_org                          = format("%s.%s", "tst", local.domain_transfer_cloudflare_zone)
}

##############################
# stg.devopsconsoritium.org
##############################
resource "aws_route53_zone" "stg_devopsconsortium_org" {
  name = local.domain_transfer_r53_stg_devops_consortium_org_subzone
}

# take control of default zone ns and soa records
# original default TTL (2-days): 172800
resource "aws_route53_record" "stg_devopscosortium_org_ns" {
  name            = local.domain_transfer_r53_stg_devops_consortium_org_subzone
  allow_overwrite = true
  ttl             = 86400 # 1-day
  type            = "NS"
  zone_id         = aws_route53_zone.stg_devopsconsortium_org.zone_id
  records         = aws_route53_zone.stg_devopsconsortium_org.name_servers
}

# original default TTL: 900
# original default record: "ns-1969.awsdns-54.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
resource "aws_route53_record" "stg_devopscosortium_org_soa" {
  name            = local.domain_transfer_r53_stg_devops_consortium_org_subzone
  allow_overwrite = true
  ttl             = 900
  type            = "SOA"
  zone_id         = aws_route53_zone.stg_devopsconsortium_org.zone_id
  records         = ["ns-1969.awsdns-54.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 3600"]
}

# aws_route53_record commented out for now instead of deleting code for future DNSSEC testing (ie key rotation)
# ref: https://jumpcloud.atlassian.net/browse/TE-273
#resource "aws_route53_record" "id_stg_devopsconsortium_org" {
#name    = "id"
#ttl     = 120
#type    = "A"
#zone_id = aws_route53_zone.stg_devopsconsortium_org.id
#records = [lookup(aws_eip.domain_transfer_instances, "tst-app-public-2").public_ip]
#}

##############################
# tst.devopsconsoritium.org
##############################
resource "aws_route53_zone" "tst_devopsconsortium_org" {
  name = local.r53_tst_devopsconsortium_org
}

# take control of default zone ns and soa records
# original default TTL: 172800
resource "aws_route53_record" "tst_devopscosortium_org_ns" {
  name            = local.r53_tst_devopsconsortium_org
  allow_overwrite = true
  ttl             = 300
  type            = "NS"
  zone_id         = aws_route53_zone.tst_devopsconsortium_org.zone_id
  records         = aws_route53_zone.tst_devopsconsortium_org.name_servers
}

# original default TTL: 900
# original default record: "ns-1768.awsdns-29.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
resource "aws_route53_record" "tst_devopscosortium_org_soa" {
  name            = local.r53_tst_devopsconsortium_org
  allow_overwrite = true
  ttl             = 300
  type            = "SOA"
  zone_id         = aws_route53_zone.tst_devopsconsortium_org.zone_id
  records         = ["ns-1768.awsdns-29.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 600"]
}

##############################
# Prepare DNSSEC for the stg.devopsconsortium.org zone
# KSK rotation for stg.devopsconsortium.org
# - date is to indicate when the ksk was rotated

module "stg_devopsconsortium_org_kms_for_ksk_05192023" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/kms/kms_key?ref=v6.11.4"

  name                     = "stg-devopsconsortium-org-ksk-05192023"
  customer_master_key_spec = "ECC_NIST_P256"
  key_usage                = "SIGN_VERIFY"
  enable_dnssec_policy     = true
  enable_key_rotation      = false # Automatic key rotation not supported for asymmetric KMS keys ie ECC
  deletion_window_in_days  = 7
  tags                     = { Environment = var.env_prefix }
}

resource "aws_route53_key_signing_key" "stg_devopsconsortium_org_05192023" {
  name                       = "${local.domain_transfer_r53_stg_devops_consortium_org_subzone}-05192023"
  hosted_zone_id             = aws_route53_zone.stg_devopsconsortium_org.id
  key_management_service_arn = module.stg_devopsconsortium_org_kms_for_ksk_05192023.arn
}

resource "cloudflare_record" "ds_stg_devopsconsortium_org_05192023" {
  zone_id = cloudflare_zone.devopsconsortium.id
  name    = local.domain_transfer_r53_stg_devops_consortium_org_subzone
  type    = "DS"
  proxied = false
  data {
    algorithm   = aws_route53_key_signing_key.stg_devopsconsortium_org_05192023.signing_algorithm_type
    digest      = aws_route53_key_signing_key.stg_devopsconsortium_org_05192023.digest_value
    digest_type = aws_route53_key_signing_key.stg_devopsconsortium_org_05192023.digest_algorithm_type
    key_tag     = aws_route53_key_signing_key.stg_devopsconsortium_org_05192023.key_tag
  }
}

resource "aws_route53_hosted_zone_dnssec" "stg_devopsconsortium_org" {
  hosted_zone_id = aws_route53_key_signing_key.stg_devopsconsortium_org_05192023.hosted_zone_id
}

##############################
# Prepare DNSSEC for the tst.devopsconsortium.org zone
# KSK rotation for tst.devopsconsortium.org
# - date is to indicate when the ksk was rotated

module "tst_devopsconsortium_org_kms_for_ksk_05162023" {
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
  name                       = "${local.r53_tst_devopsconsortium_org}-05162023"
  hosted_zone_id             = aws_route53_zone.tst_devopsconsortium_org.id
  key_management_service_arn = module.tst_devopsconsortium_org_kms_for_ksk_05162023.arn
}

resource "aws_route53_hosted_zone_dnssec" "tst_devopsconsortium_org" {
  hosted_zone_id = aws_route53_key_signing_key.tst_devopsconsortium_org_05162023.hosted_zone_id
}

resource "cloudflare_record" "ds_tst_devopsconsortium_org_05162023" {
  zone_id = cloudflare_zone.devopsconsortium.id
  name    = "tst.devopsconsortium.org"
  type    = "DS"
  proxied = false
  data {
    algorithm   = aws_route53_key_signing_key.tst_devopsconsortium_org_05162023.signing_algorithm_type
    digest      = aws_route53_key_signing_key.tst_devopsconsortium_org_05162023.digest_value
    digest_type = aws_route53_key_signing_key.tst_devopsconsortium_org_05162023.digest_algorithm_type
    key_tag     = aws_route53_key_signing_key.tst_devopsconsortium_org_05162023.key_tag
  }
}

##############################

locals {
  domain_transfer_cloudflare_tst_a_records = [
    # A record commented out for now instead of deleting code for future DNSSEC testing (ie key rotation)
    # ref: https://jumpcloud.atlassian.net/browse/TE-273
    #{
    #name    = "@",
    #proxied = true
    #ttl     = 1,
    #type    = "A",
    #value   = lookup(aws_eip.domain_transfer_instances, "tst-app-public").public_ip
    #},
  ]
}

resource "cloudflare_zone" "devopsconsortium" {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = var.cloudflare_account_id
  paused     = false
  plan       = "free"
  type       = "full"
  zone       = local.domain_transfer_cloudflare_zone
}

# use output of cloudflare_zone_dnssec.devopsconsortium_org to get the
# needed info to manually create the DS record for devopsconsortium.org in Godaddy
# there are 3rd party providers for Godaddy but nothing official
# ie terraform state show cloudflare_zone_dnssec.devopsconsortium_org
#   cloudflare_zone_dnssec.devopsconsortium_org:
#     resource "cloudflare_zone_dnssec" "devopsconsortium_org" {
#       algorithm        = "13"
#       digest           = "BB9AEE5E0E576CA35AEC4EE816EF5C3339952DB81F6E47E602D218B6516738A9"
#       digest_algorithm = "SHA256"
#       digest_type      = "2"
#       ds               = "devopsconsortium.org. 3600 IN DS 2371 13 2 BB9AEE5E0E576CA35AEC4EE816EF5C3339952DB81F6E47E602D218B6516738A9"
#       flags            = 257
#       id               = "14fa793fedd155933368f8f094629fe4"
#       key_tag          = 2371
#       key_type         = "ECDSAP256SHA256"
#       modified_on      = "Fri, 30 Sep 2022 17:30:24 +0000"
#       public_key       = "mdsswUyr3DPW132mOi8V9xESWE8jTo0dxCjjnopKl+GqJxpVXckHAeF+KkxLbxILfDLUT0rAK9iUzy1L53eKGQ=="
#       status           = "active"
#       zone_id          = "14fa793fedd155933368f8f094629fe4"
#   }
#
# the data values needed for Goddady are:
#   Algorithm (algorithm)
#   Digest (digest)
#   Digest Type (digest_type)
#   Key Tag (key_tag)
#
resource "cloudflare_zone_dnssec" "devopsconsortium_org" {
  zone_id = cloudflare_zone.devopsconsortium.id
}

### agent.devopsconsortium.org
resource "cloudflare_zone" "agent_devopsconsortium_org" {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = var.cloudflare_account_id
  paused     = false
  plan       = "free"
  type       = "full"
  zone       = local.cloudlare_agent_devopsconsortium_org
}

resource "cloudflare_zone_dnssec" "agent_devopsconsortium_org" {
  zone_id = cloudflare_zone.agent_devopsconsortium_org.id
}

resource "cloudflare_record" "ds_agent_devopsconsortium_org" {
  zone_id = cloudflare_zone.devopsconsortium.id
  name    = "agent"
  type    = "DS"
  proxied = false
  data {
    algorithm   = cloudflare_zone_dnssec.agent_devopsconsortium_org.algorithm
    digest      = cloudflare_zone_dnssec.agent_devopsconsortium_org.digest
    digest_type = cloudflare_zone_dnssec.agent_devopsconsortium_org.digest_type
    key_tag     = cloudflare_zone_dnssec.agent_devopsconsortium_org.key_tag
  }
}

module "domain_transfer_devopconsortium_dns" {
  source  = "app.terraform.io/jumpcloud/dns/cloudflare"
  version = "2.0.1"

  zone_id     = cloudflare_zone.devopsconsortium.id
  zone_name   = local.domain_transfer_cloudflare_zone
  dns_records = local.domain_transfer_cloudflare_tst_a_records
  ns_delegation = [
    {
      name  = "stg" # delegating cloudflare NS record to r53 stg.devopconsortium.org zone name servers
      ttl   = 300
      value = aws_route53_zone.stg_devopsconsortium_org.name_servers
    },
    {
      name  = "tst" # delegating cloudflare NS record to r53 tst.devopconsortium.org zone name servers
      ttl   = 300
      value = aws_route53_zone.tst_devopsconsortium_org.name_servers
    },
    {
      name  = "agent" # delegating cloudflare NS record to cloudflare zone agent.devopconsortium.org zone name servers
      ttl   = 300
      value = cloudflare_zone.agent_devopsconsortium_org.name_servers
    }
  ]
}
