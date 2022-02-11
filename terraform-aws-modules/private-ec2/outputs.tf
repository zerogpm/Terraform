output "private_ec2_ids" {
  value = [for i in module.ec2-instance-private[*].id : i]
}

output "private_ec2_app1_private_ip" {
  value = [for i in module.ec2-instance-private[*].private_ip : i]
}