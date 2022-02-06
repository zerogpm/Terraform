#--- aws-modules/main.tf ---

module "custom-vpc" {
  source          = "./vpc"
  vpc_cider       = local.vpc_cider
  public_subnets  = [for i in range(1, 3, 1) : cidrsubnet("10.0.0.0/16", 8, i)]
  private_subnets = [for i in range(101, 103, 1) : cidrsubnet("10.0.0.0/16", 8, i)]
  security_groups = local.security_group
}

module "compute" {
  source          = "./compute"
  instance_count  = 2
  key_name        = "remote-key"
  public_subnets  = module.custom-vpc.public_subnets
  public_key_path = var.public_key_path
  instance_type   = "t3.micro"
  vol_size        = 10
  user_data_path  = "${path.root}/userdata.tpl"
  public_sg       = module.custom-vpc.public_sg
}

module "bastion-host" {
  source = "./bastion"
  instance_type = "t3.micro"
  key_name = "remote-key"
  public_subnets = module.custom-vpc.public_subnets
  public_sg = module.custom-vpc.bastion_sg
}

module "private-ec2" {
  source = "./private-ec2"
  instance_type = "t3.micro"
  key_name = "remote-key"
  private_subnets = module.custom-vpc.private_subnets
  private_sg = module.custom-vpc.private_sg
  user_data_path  = "${path.root}/userdata.tpl"
  vpc = module.custom-vpc
}