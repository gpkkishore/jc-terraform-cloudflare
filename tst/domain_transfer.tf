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
  source = "git@github.com:JudeQuintana/terraform-modules.git//networking/tiered_vpc_ng?ref=v1.4.2"

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

resource "aws_instance" "domain_transfer_instances" {
  for_each = local.instance_name_to_instance

  ami                    = "ami-0dc2d3e4c0f9ebd18" # AWS Linux 2 us-east-1
  instance_type          = "t2.micro"
  key_name               = "domain-transfer-test" # manually created in us-east-1
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = each.value.vpc_security_group_ids
  user_data              = <<EOF
#!/bin/bash
sudo hostname ${each.value.name}
sudo yum update -y
sudo amazon-linux-extras install nginx1
echo "hello world" | sudo tee /usr/share/nginx/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx
EOF
  tags = {
    Name = each.value.name
  }
}

# each ec2 instance will get an EIP
resource "aws_eip" "domain_transfer_instances" {
  for_each = local.instance_name_to_instance

  vpc      = true
  instance = lookup(aws_instance.domain_transfer_instances, each.key).id
}


locals {
  domain_transfer_cloudflare_zone                       = "devopsconsortium.org"
  domain_transfer_r53_stg_devops_consortium_org_subzone = format("%s.%s", "stg", local.domain_transfer_cloudflare_zone)
}

resource "aws_route53_zone" "stg_devopsconsortium_org" {
  name = local.domain_transfer_r53_stg_devops_consortium_org_subzone
}

# take control of default zone ns and soa records
# original default TTL: 172800
resource "aws_route53_record" "stg_devopscosortium_org_ns" {
  name            = local.domain_transfer_r53_stg_devops_consortium_org_subzone
  allow_overwrite = true
  ttl             = 300
  type            = "NS"
  zone_id         = aws_route53_zone.stg_devopsconsortium_org.zone_id
  records         = aws_route53_zone.stg_devopsconsortium_org.name_servers
}

# original default TTL: 900
# original default record: "ns-1969.awsdns-54.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
resource "aws_route53_record" "stg_devopscosortium_org_soa" {
  name            = local.domain_transfer_r53_stg_devops_consortium_org_subzone
  allow_overwrite = true
  ttl             = 300
  type            = "SOA"
  zone_id         = aws_route53_zone.stg_devopsconsortium_org.zone_id
  records         = ["ns-1969.awsdns-54.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 600"]
}

resource "aws_route53_record" "id_stg_devopsconsortium_org" {
  name    = "id"
  ttl     = 120
  type    = "A"
  zone_id = aws_route53_zone.stg_devopsconsortium_org.id

  records = [lookup(aws_eip.domain_transfer_instances, "tst-app-public-2").public_ip]
}

module "dnssec_alert_sns_topic_2" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/sns?ref=TE-80-sns-email-support"

  env_prefix         = var.env_prefix
  region_short_names = var.region_az_labels
  topic_name         = "dnssec-errors-2"
  tags               = { Environment = var.env_prefix }
  subscriptions = [
    {
      protocol = "email"
      endpoint = "jude.quintana@jumpcloud.com"
    }
  ]
}

##############################
# Enable DNSSEC for subdomain
##############################
module "stg_devopsconsortium_kms_for_ksk" {
  source = "git@github.com:TheJumpCloud/terraform-modules.git//infrastructure/kms/kms_key?ref=v6.6.3"

  name                     = "stg-devopsconsortium-org-ksk"
  customer_master_key_spec = "ECC_NIST_P256"
  key_usage                = "SIGN_VERIFY"
  enable_dnssec_policy     = true
  enable_key_rotation      = false # Automatic key rotation not supported for asymmetric KMS keys ie ECC
  deletion_window_in_days  = 7
  tags                     = { Environment = var.env_prefix }
}

resource "aws_route53_key_signing_key" "stg_devopsconsortium_org" {
  name                       = local.domain_transfer_r53_stg_devops_consortium_org_subzone
  hosted_zone_id             = aws_route53_zone.stg_devopsconsortium_org.id
  key_management_service_arn = module.stg_devopsconsortium_kms_for_ksk.arn
}

resource "aws_route53_hosted_zone_dnssec" "stg_devopsconsortium_org" {
  hosted_zone_id = aws_route53_key_signing_key.stg_devopsconsortium_org.hosted_zone_id
}

##############################

locals {
  domain_transfer_cloudflare_tst_a_records = [
    {
      name    = "@",
      proxied = true
      ttl     = 1,
      type    = "A",
      value   = lookup(aws_eip.domain_transfer_instances, "tst-app-public").public_ip
    },
  ]
}

resource "cloudflare_zone" "devopsconsortium" {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = "3c96d914c0eaa62b7b4c9960e63818f7"
  paused     = false
  plan       = "free"
  type       = "full"
  zone       = local.domain_transfer_cloudflare_zone
}

resource "cloudflare_zone_dnssec" "devopsconsortium_org" {
  zone_id = cloudflare_zone.devopsconsortium.id
}

# Add a "stg" DS record to validate DNSSEC for the stg.devopsconsortium.org subdomain in Route53
# data values needed can't be pull directly from aws_route53_hosted_zone_dnssec resource directly
# they have to be manually copied over from the hosted zone in the AWS UI (ie make ds record in cloudflare):
#   under DNSSEC Signing -> View Information to create DS record -> under Establish chain of Trust -> Another domain registrar
# the data values neede are:
# algorithm (Signing Algorithm Type)
# digest (Digest)
# digest_type (Digest Algorithm Type)
# key_tag (Key Tag)
#
# otherwise all other values are 0
resource "cloudflare_record" "ds_stg_devopsconsortium_org" {
  zone_id = cloudflare_zone.devopsconsortium.id
  name    = "stg"
  type    = "DS"
  proxied = false
  data {
    algorithm      = 13
    altitude       = 0
    digest         = "D48F6FF7E7AE6613B833B318F142B7BE94D1B4D0A05A15FD567A44ADF753990E"
    digest_type    = 2
    key_tag        = 43419
    lat_degrees    = 0
    lat_minutes    = 0
    lat_seconds    = 0
    long_degrees   = 0
    long_minutes   = 0
    long_seconds   = 0
    matching_type  = 0
    order          = 0
    port           = 0
    precision_horz = 0
    precision_vert = 0
    preference     = 0
    priority       = 0
    protocol       = 0
    selector       = 0
    size           = 0
    type           = 0
    usage          = 0
    weight         = 0
  }
}

module "domain_transfer_devopconsortium_dns" {
  source  = "app.terraform.io/jumpcloud/dns/cloudflare"
  version = "1.0.0"

  zone_id     = cloudflare_zone.devopsconsortium.id
  zone_name   = local.domain_transfer_cloudflare_zone
  dns_records = local.domain_transfer_cloudflare_tst_a_records
  ns_delegation = [
    {
      name  = "stg" # delegating cloudflare NS record to r53 stg.devopconsortium.org zone name servers
      ttl   = 300
      value = aws_route53_zone.stg_devopsconsortium_org.name_servers
    }
  ]
  enable_noncore = false
}
