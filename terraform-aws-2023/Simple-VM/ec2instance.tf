# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  for_each = var.availability_zone_map
  ami           = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  /* key_name      = var.instance_keypair */
  vpc_security_group_ids = [
    aws_security_group.vpc-ssh.id,
    aws_security_group.vpc-web.id
  ]
  availability_zone = each.value
  user_data = templatefile("${path.root}/userdata.tpl", {})
  tags = {
    "Name" = "EC2-Demo2-${each.value}"
  }
}