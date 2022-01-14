# --- networking.main.tf ---
# Declare the data source
data "aws_availability_zones" "available" {}

resource "random_integer" "random" {
  max = 10
  min = 1
}

resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names
  result_count = var.max_subnets
}

resource "aws_vpc" "bu_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  lifecycle {
    create_before_destroy = true
  }

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
  count             = var.private_sn_count
  cidr_block        = var.private_cidrs[count.index]
  vpc_id            = aws_vpc.bu_vpc.id
  availability_zone = random_shuffle.az_list.result[count.index]

  tags = {
    Name = "bu_private_${count.index + 1}"
  }
}

resource "aws_internet_gateway" "bu-Internet_gateway" {
  vpc_id = aws_vpc.bu_vpc.id
  depends_on = [
    aws_vpc.bu_vpc
  ]
  tags = {
    Name = "bu-IGW"
  }
}

resource "aws_route_table" "bu-public_rt" {
  vpc_id = aws_vpc.bu_vpc.id
  tags = {
    Name = "bu-public-route-table"
  }
}

resource "aws_route_table_association" "bu_public_assoc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.bu-public_subnet[count.index].id
  route_table_id = aws_route_table.bu-public_rt.id
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.bu-public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.bu-Internet_gateway.id
}

resource "aws_default_route_table" "bu-private-rt" {
  default_route_table_id = aws_vpc.bu_vpc.default_route_table_id
  tags = {
    Name = "bu-private-route-table"
  }
}

resource "aws_security_group" "bu_sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.bu_vpc.id
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      protocol    = ingress.value.protocol
      to_port     = ingress.value.to
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}