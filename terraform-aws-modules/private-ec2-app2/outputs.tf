output "private_ec2_app2_ids" {
  value = [for i in module.ec2-instance-private-app2[*].id : i]
}

output "private_ec2_app2_private_ip" {
  value = [for i in module.ec2-instance-private-app2[*].private_ip : i]
}