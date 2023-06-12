# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  key_name = var.instance_keypair
  vpc_security_group_ids = [
    aws_security_group.vpc-ssh.id,
    aws_security_group.vpc-web.id
  ]
  user_data = templatefile("${path.root}/userdata.tpl", {})
  tags = {
    "Name" = "EC2-Demo2"
  }
}