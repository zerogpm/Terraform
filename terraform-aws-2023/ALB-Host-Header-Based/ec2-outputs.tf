# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "List of IDs of instances"
  value       = module.ec2_public.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "List of public IP addresses assigned to the instances"
  value       = module.ec2_public.public_ip
}

# Private EC2 Instances
## ec2_private_instance_ids

output "ec2_private_instance_app1_ids" {
  description = "List of IDs of instances"
  #value       = [module.ec2_private.id]
  value = [for ec2private in module.ec2_private_app1 : ec2private.id]
}

## ec2_private_ip
output "ec2_private_app1_ip" {
  description = "List of private IP addresses assigned to the instances"
  #value       = [module.ec2_private.private_ip]
  value = [for ec2private in module.ec2_private_app1 : ec2private.private_ip]
}

output "ec2_private_instance_app2_ids" {
  description = "List of IDs of instances"
  #value       = [module.ec2_private.id]
  value = [for ec2private in module.ec2_private_app2 : ec2private.id]
}

## ec2_private_ip
output "ec2_private_app2_ip" {
  description = "List of private IP addresses assigned to the instances"
  #value       = [module.ec2_private.private_ip]
  value = [for ec2private in module.ec2_private_app2 : ec2private.private_ip]
}