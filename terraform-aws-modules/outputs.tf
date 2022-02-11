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

output "alb_public_subnets" {
  value = module.custom-vpc.alb_public_sg
}

output "ec2-app-1-ids" {
  value = module.private-ec2.private_ec2_ids
}

output "ec2-app-1-private-ip" {
  value = module.private-ec2.private_ec2_app1_private_ip
}

output "ec2-app-2-ids" {
  value = module.private-ec2-app2.private_ec2_app2_ids
}

output "ec2-app-2-private-ip" {
  value = module.private-ec2-app2.private_ec2_app2_private_ip
}

