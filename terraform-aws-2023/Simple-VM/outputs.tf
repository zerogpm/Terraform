# Terraform Output Values

# EC2 Instance Public IP
output "instance_publicip" {
  description = "EC2 Instance Public IP"
  value       = { for k, v in aws_instance.myec2vm : k => v.public_ip }
}

# EC2 Instance Public DNS
output "instance_publicdns" {
  description = "EC2 Instance Public DNS"
  value       = {for k, v in aws_instance.myec2vm : k => v.public_dns}
}

# EC2 Instance Public DNS
output "image-id" {
  description = "EC2 Instance Public DNS"
  value       = data.aws_ami.amzlinux2.id
}