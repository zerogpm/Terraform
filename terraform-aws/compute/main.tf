#--- compute/main.tf ---
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
  key_name               = aws_key_pair.bu-key.id
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnets[count.index]
  user_data = templatefile(var.user_data_path, {
    nodename = "bu-node-${random_id.bu-node-id[count.index].dec}"
    db_endpoint = var.db_endpoint
    dbuser = var.dbuser
    dbpass = var.dbpassword
    dbname = var.dbname
  })
  root_block_device {
    volume_size = var.vol_size
  }
}

