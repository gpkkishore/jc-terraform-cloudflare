###########################################
# DNS Configuration for internal domain.
# TODO: Move this into it's own workspace
###########################################
data "aws_route53_zone" "zones_with_dnssec" {
  name = "jcplatform.dev"
}