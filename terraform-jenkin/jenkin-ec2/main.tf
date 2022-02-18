data "aws_ami" "server-ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
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
  name                   = "jenkin-host-${random_id.bu-node-id[count.index].dec}"
  instance_type          = var.instance_type
  key_name               = var.key_name
  ami                    = data.aws_ami.server-ami.id
  vpc_security_group_ids = [var.public_sg]
  user_data = templatefile(var.user_data_path, {
    app-name   = "LOL",
    app-number = "app1"
  })
  subnet_id              = var.public_subnets[count.index]
}