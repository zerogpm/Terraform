output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "public_sg" {
  value = aws_security_group.bu_sg["public"].id
}