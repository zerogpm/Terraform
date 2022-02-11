# ACM Module - To create and Verify SSL Certificates
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.3.0"

  domain_name  = trimsuffix(var.zone_name, ".")
  zone_id      = var.zone_id

  subject_alternative_names = [
    "*.${trimsuffix(var.zone_name, ".")}"
  ]
}