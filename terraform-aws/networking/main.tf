# --- networking.main.tf ---

resource "random_integer" "random" {
  max = 10
  min = 1
}

resource "aws_vpc" "bu_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "bu_vpc-${random_integer.random.id}"
  }
}