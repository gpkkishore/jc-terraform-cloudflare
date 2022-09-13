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
      # app-public
      name = format("%s-%s-public", var.env_prefix, local.tiered_vpc_names.app)
      # lookup the first public subnet id that belongs to AZ 'a' in the 'app' VPC
      subnet_id = lookup(lookup(module.vpcs, local.tiered_vpc_names.app).az_to_public_subnet_ids, "a")[0]
      vpc_security_group_ids = [
        lookup(module.vpcs, local.tiered_vpc_names.app).default_security_group_id,
        lookup(module.vpcs, local.tiered_vpc_names.app).intra_vpc_security_group_id
      ]
    }
  ]
}

resource "aws_instance" "domain_transfer_instances" {
  for_each = { for i in local.instances : i.name => i }

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
sudo systemctl start nginx
EOF
  tags = {
    Name = each.value.name
  }
}

locals {
  domain_transfer_zone = "devopsconsortium.org"
  domain_transfer_tst_a_records = [
    {
      name    = "@",
      proxied = true
      ttl     = 1,
      type    = "A",
      value   = "18.234.173.155"
    },
  ]
}

resource "cloudflare_zone" "devopsconsortium" {
  # Temporary workaround for a provider bug, more info: https://github.com/cloudflare/terraform-provider-cloudflare/issues/1711
  account_id = "3c96d914c0eaa62b7b4c9960e63818f7"
  paused     = false
  plan       = "free"
  type       = "full"
  zone       = local.domain_transfer_zone
}

module "domain_transfer_devopconsortium_dns" {
  source = "git@github.com:TheJumpCloud/terraform-cloudflare.git//modules/dns?ref=v1.0.1"

  zone_id        = cloudflare_zone.devopsconsortium.id
  zone_name      = local.domain_transfer_zone
  dns_records    = local.domain_transfer_tst_a_records
  ns_delegation  = []
  enable_noncore = false
}
