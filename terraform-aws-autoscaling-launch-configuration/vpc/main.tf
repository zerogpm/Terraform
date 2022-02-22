data "aws_availability_zones" "bu-zones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"
  # insert the 23 required variables here
  name = "vpc-asg-dev"
  cidr = var.vpc_cider

  azs             = data.aws_availability_zones.bu-zones.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  #Nat GateWays
  enable_nat_gateway = true
  single_nat_gateway = true

  #VPC DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Name = "public-subnets"
  }

  private_subnet_tags = {
    Name = "private-subnets"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
}

resource "aws_security_group" "bu_sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = module.vpc.vpc_id
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