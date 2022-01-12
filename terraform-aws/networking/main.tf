# --- networking.main.tf ---
# Declare the data source
data "aws_availability_zones" "available" {}

resource "random_integer" "random" {
  max = 10
  min = 1
}

resource "random_shuffle" "az_list" {
  input = data.aws_availability_zones.available.names
  result_count = var.max_subnets
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
  count                   = var.public_sn_count
  cidr_block              = var.public_cidrs[count.index]
  vpc_id                  = aws_vpc.bu_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "bu_public_${count.index + 1}"
  }
}

resource "aws_subnet" "bu-private_subnet" {
  count = var.private_sn_count
  cidr_block = var.private_cidrs[count.index]
  vpc_id     = aws_vpc.bu_vpc.id
  availability_zone = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "bu_private_${count.index + 1}"
  }
}