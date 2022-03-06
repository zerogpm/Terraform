data "aws_ami" "centos-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["aws-parallelcluster-2.0.0-centos7-hvm-201811120751"]
  }
}

resource "random_id" "bu-node-id" {
  byte_length = 2
  count       = var.instance_count
  keepers = {
    key_name = var.key_name
  }
}

module "ec2-instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "3.4.0"
  count = var.instance_count
  name                   = "${var.host_name}-${random_id.bu-node-id[count.index].dec}"
  instance_type          = var.instance_type
  key_name               = var.key_name
  ami                    = data.aws_ami.centos-ami.id
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnets[count.index]
}