#output "IP-address" {
#  value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address, i.ports[0].external]) ]
#  description = "The ip address and external port"
#}
#
#output "container-name" {
#  value = docker_container.nodered_container.name
#  description = "The name of the container"
#}

output "application_access" {
  value = {
    for x in docker_container.app_container[*] : x.name => join(":", [x.ip_address], x.ports[*]["external"])
  }
}