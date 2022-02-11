# Get DNS information from AWS Route53
data "aws_route53_zone" "mydomain" {
  name = var.domain
}