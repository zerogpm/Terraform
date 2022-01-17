#-- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.bu_vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.bu-rds-subnet-group.*.name
}

output "db_security_group" {
  value = [aws_security_group.bu_sg["rds"].id]
}