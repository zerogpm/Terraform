module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"
  # insert the 23 required variables here
  name = "vpc-dev"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = [for i in range(1, 3, 1) : cidrsubnet("10.0.0.0/16", 8, i)]
  public_subnets  = [for i in range(101, 103, 1) : cidrsubnet("10.0.0.0/16", 8, i)]

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