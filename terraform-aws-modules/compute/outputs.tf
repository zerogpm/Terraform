output "availability_zones" {
  value = data.aws_availability_zones.bu-zones.names
}
