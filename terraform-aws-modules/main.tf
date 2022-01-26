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
  instance_count  = 1
  key_name        = "remote-key"
  public_subnets  = module.custom-vpc.public_subnets
  public_key_path = var.public_key_path
  instance_type   = "t3.micro"
  vol_size        = 10
  user_data_path  = "${path.root}/userdata.tpl"
  public_sg       = module.custom-vpc.public_sg
}