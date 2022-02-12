# Get DNS information from AWS Route53
data "aws_route53_zone" "mydomain" {
  name = var.domain
}

# DNS Registration
resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = "apps.${var.domain}"
  type    = "A"
  alias {
    name                   = var.alb_dns
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}