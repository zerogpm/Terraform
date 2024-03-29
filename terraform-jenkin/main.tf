module "custom-vpc" {
  source          = "./vpc"
  vpc_cider       = local.vpc_cidr
  public_subnets  = [for i in range(1, 3, 1) : cidrsubnet("10.0.0.0/16", 8, i)]
  private_subnets = [for i in range(101, 103, 1) : cidrsubnet("10.0.0.0/16", 8, i)]
  security_groups = local.security_group
}

module "ec2-key-chain" {
  source = "./ec2-key-chain"
  key_name        = "remote-key"
  public_key_path = var.public_key_path
}

module "jenkin-ec2" {
  source = "./jenkin-ec2"
  instance_type   = "t3.micro"
  host_name = "jenkins"
  instance_count  = 1
  key_name        = "remote-key"
  public_subnets = module.custom-vpc.public_subnets
  public_sg      = module.custom-vpc.public_sg
  user_data_path  = "${path.root}/userdata.tpl"
  vpc             = module.custom-vpc
}

#module "ansible-ec2" {
#  source = "./jenkin-ec2"
#  instance_type   = "t3.micro"
#  host_name = "ansible"
#  instance_count  = 1
#  key_name        = "remote-key"
#  public_subnets = module.custom-vpc.public_subnets
#  public_sg      = module.custom-vpc.public_sg
#  user_data_path  = "${path.root}/userdata.tpl"
#  vpc             = module.custom-vpc
#}

#module "centos-ec2" {
#  source = "./centos-ec2"
#  instance_type   = "t3.micro"
#  host_name = "centos"
#  instance_count  = 1
#  key_name        = "remote-key"
#  public_subnets = module.custom-vpc.public_subnets
#  public_sg      = module.custom-vpc.public_sg
#  vpc             = module.custom-vpc
#}