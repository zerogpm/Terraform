#--- aws-modules/main.tf ---

module "custom-vpc" {
  source          = "./vpc"
  vpc_cider       = local.vpc_cider
  public_subnets  = [for i in range(1, 3, 1) : cidrsubnet("10.0.0.0/16", 8, i)]
  private_subnets = [for i in range(101, 103, 1) : cidrsubnet("10.0.0.0/16", 8, i)]
  security_groups = local.security_group
}

module "ec2-key-chain" {
  source          = "./ec2-key-chain"
  key_name        = "remote-key"
  public_key_path = var.public_key_path
}

#module "compute" {
#  source          = "./compute"
#  instance_count  = 1
#  key_name = "remote-key"
#  key_id = module.ec2-key-chain.key-id
#  public_subnets  = module.custom-vpc.public_subnets
#  instance_type   = "t3.micro"
#  vol_size        = 10
#  user_data_path  = "${path.root}/userdata.tpl"
#  public_sg       = module.custom-vpc.public_sg
#}

#module "bastion-host" {
#  source         = "./bastion"
#  instance_type  = "t3.micro"
#  key_name       = "remote-key"
#  public_subnets = module.custom-vpc.public_subnets
#  public_sg      = module.custom-vpc.bastion_sg
#  vpc            = module.custom-vpc
#}

module "private-ec2" {
  source          = "./private-ec2"
  instance_type   = "t3.micro"
  instance_count  = 2
  key_name        = "remote-key"
  private_subnets = module.custom-vpc.private_subnets
  private_sg      = module.custom-vpc.private_sg
  user_data_path  = "${path.root}/userdata.tpl"
  vpc             = module.custom-vpc
}

module "application-load-balancer" {
  source          = "./application-load-balancer"
  vpc_id          = module.custom-vpc.vpc_id
  security_groups = module.custom-vpc.alb_public_sg
  subnets = module.custom-vpc.public_subnets
  private_ec2_ids = module.private-ec2.private_ec2_ids
}