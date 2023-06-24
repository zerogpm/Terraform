# Resource: EC2 Instance
resource "aws_instance" "myec2vm" {
  ami           = "ami-0742b4e673072066f"
  instance_type = "t3.micro"
  key_name      = "aws"
  user_data     = templatefile("${path.root}/userdata.tpl", {})
  tags = {
    "Name" = "EC2 Demo"
  }
}