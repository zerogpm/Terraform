#-- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.bu_vpc.id
}