output "vpc_id" {
  value = module.custom-vpc.vpc_id
}

output "public_subnets" {
  value = module.custom-vpc.public_subnets
}

output "private_subnets" {
  value = module.custom-vpc.private_subnets
}

output "security_public_sg" {
  value = module.custom-vpc.public_sg
}

#output "centos_ec2_id" {
#  value = module.centos-ec2.centos_ec2_ips
#}
#
#output "ansible_ec2_id" {
#  value = module.ansible-ec2.ansible_ec2_ips
#}
