module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.3"
  # insert the 23 required variables here
  name = "vpc-dev"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

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
    Terraform = "true"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-dev"
  }
}