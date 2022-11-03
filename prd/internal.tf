###########################################
# DNS Configuration for internal domain.
# TODO: Move this into it's own workspace
###########################################
resource "aws_route53_zone" "jc_internal_zone" {
  name = "jcplatform.dev"
}
