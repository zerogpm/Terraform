data "aws_ami" "server-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

module "ec2-instance-private" {
  depends_on = [var.vpc]
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.4.0"
  for_each = toset(["0", "1"])
  name = "private_ec2-vm-${each.key}"
  instance_type = var.instance_type
  key_name = var.key_name
  ami = data.aws_ami.server-ami.id
  vpc_security_group_ids  = [var.private_sg]
  user_data = templatefile(var.user_data_path, {})
  subnet_id = element(var.private_subnets, tonumber(each.key))
}