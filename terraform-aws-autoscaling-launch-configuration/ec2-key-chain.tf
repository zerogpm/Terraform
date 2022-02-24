resource "aws_key_pair" "bu-key" {
  key_name   = "remote-key"
  public_key = file(var.public_key_path)
}