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

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.4.0"
  name = "bastion-host"
  instance_type = var.instance_type
  key_name = var.key_name
  ami = data.aws_ami.server-ami.id
  subnet_id = var.public_subnets[0]
  vpc_security_group_ids  = [var.public_sg]
}