module "custom-vpc" {
  source          = "./vpc"
  vpc_cider       = local.vpc_cidr
  public_subnets  = [for i in range(1, 3, 1) : cidrsubnet("10.0.0.0/16", 8, i)]
  private_subnets = [for i in range(101, 103, 1) : cidrsubnet("10.0.0.0/16", 8, i)]
  security_groups = local.security_group
}

module "bastion" {
  source = "./bastion-host"
}