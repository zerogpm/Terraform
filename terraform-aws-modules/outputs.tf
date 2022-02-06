output "vpc_id" {
  value = module.custom-vpc.vpc_id
}

output "public_subnets" {
  value = module.custom-vpc.public_subnets
}

output "private_subnets" {
  value = module.custom-vpc.private_subnets
}