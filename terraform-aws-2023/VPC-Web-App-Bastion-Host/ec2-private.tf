# AWS EC2 Instance Terraform Module
# Bastion Host - EC2 Instance that will be created in VPC Public Subnet
module "ec2_private" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.1.0"
  #for_each = toset([ module.vpc.private_subnets[0],module.vpc.private_subnets[1] ])
  for_each = toset(["0", "1"])
  subnet_id = element(module.vpc.private_subnets, tonumber(each.key))
  # insert the 10 required variables here
  name          = "${var.environment}-BastionHost"
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name      = var.instance_keypair
  #monitoring             = true

  vpc_security_group_ids = [module.private_sg.security_group_id]
  user_data              = templatefile("${path.root}/userdata.tpl", {})
  tags                   = local.common_tags
}