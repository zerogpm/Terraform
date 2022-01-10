# --- networking.main.tf ---

resource "random_integer" "random" {
  max = 10
  min = 1
}

resource "aws_vpc" "bu_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "bu_vpc-${random_integer.random.id}"
  }
}

resource "aws_subnet" "bu-public_subnet" {
  count                   = length(var.public_cidrs)
  cidr_block              = var.public_cidrs[count.index]
  vpc_id                  = aws_vpc.bu_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"][count.index]

  tags = {
    Name = "bu_public_${count.index + 1}"
  }
}