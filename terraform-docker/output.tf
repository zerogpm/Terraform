output "IP-address" {
  value = flatten(module.container[*].IP-address)
  description = "The ip address and external port"
}

output "container-name" {
  value = module.container[*].container-name
  description = "The name of the container"
}