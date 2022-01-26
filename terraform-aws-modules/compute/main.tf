#--- compute/main.tf ---
data "aws_ami" "server-ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20211223.0-x86_64-gp2"]
  }
}

resource "random_id" "bu-node-id" {
  byte_length = 2
  count       = var.instance_count
  keepers = {
    key_name = var.key_name
  }
}

resource "aws_key_pair" "bu-key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "bu-node" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.server-ami.id
  tags = {
    Name = "bu-node-${random_id.bu-node-id[count.index].dec}"
  }
  key_name = aws_key_pair.bu-key.id
  #  vpc_security_group_ids = [var.public_sg]
  subnet_id = var.public_subnets[count.index]
  user_data = templatefile(var.user_data_path, {})
  root_block_device {
    volume_size = var.vol_size
  }
}