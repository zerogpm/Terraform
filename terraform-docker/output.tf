#output "IP-address" {
#  value = flatten(module.container[*].IP-address)
#  description = "The ip address and external port"
#}
#
#output "container-name" {
#  value = module.container[*].container-name
#  description = "The name of the container"
#}

output "application_access" {
  value = [for x in module.container[*]: x]
}