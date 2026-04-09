# Find all dev-usw2 EKS NAT Gateway IDs
data "aws_nat_gateways" "dev-usw2-eks-nat-gws" {
  provider = aws.control-usw2

  filter {
    name   = "tag:Name"
    values = ["dev-usw2-p*-nat-*", "dev-usw2-w*-nat-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# Iterate over the dev-usw2 EKS NAT Gateway IDs
data "aws_nat_gateway" "dev-usw2-eks-nat-gw" {
  provider = aws.control-usw2

  for_each = toset(data.aws_nat_gateways.dev-usw2-eks-nat-gws.ids)

  id = each.value
}

# Find all dev-euc1 EKS NAT Gateway IDs
data "aws_nat_gateways" "dev-euc1-eks-nat-gws" {
  provider = aws.control-euc1

  filter {
    name   = "tag:Name"
    values = ["dev-euc1-p*-nat-*", "dev-euc1-w*-nat-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# Iterate over the dev-euc1 EKS NAT Gateway IDs
data "aws_nat_gateway" "dev-euc1-eks-nat-gw" {
  provider = aws.control-euc1

  for_each = toset(data.aws_nat_gateways.dev-euc1-eks-nat-gws.ids)

  id = each.value
}

# Find all dev-aps1 EKS NAT Gateway IDs
data "aws_nat_gateways" "dev-aps1-eks-nat-gws" {
  provider = aws.control-aps1

  filter {
    name   = "tag:Name"
    values = ["dev-aps1-p*-nat-*", "dev-aps1-w*-nat-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# Iterate over the dev-aps1 EKS NAT Gateway IDs
data "aws_nat_gateway" "dev-aps1-eks-nat-gw" {
  provider = aws.control-aps1

  for_each = toset(data.aws_nat_gateways.dev-aps1-eks-nat-gws.ids)

  id = each.value
}

