output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_sg" {
  value = aws_security_group.bu_sg["public"].id
}

output "private_sg" {
  value = aws_security_group.bu_sg["private"].id
}

output "bastion_sg" {
  value = aws_security_group.bu_sg["bastion_host"].id
}

output "alb_public_sg" {
  value = aws_security_group.bu_sg["alb"].id
}