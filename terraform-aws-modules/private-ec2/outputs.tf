output "private_ec2_ids" {
  value = [for i in module.ec2-instance-private[*].id : i]
}
