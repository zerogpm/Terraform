output "centos_ec2_ips" {
  value = [for i in module.ec2-instance[*].public_ip : i]
}