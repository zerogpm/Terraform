terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {}

resource "random_uuid" "random" {
  count = 2
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  count = 2
  name  = join("-", ["nodered", random_uuid.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    #external = 1880
  }
}

output "IP-address" {
  value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address, i.ports[0].external]) ]
  description = "The ip address and external port"
}

output "container-name" {
  value = docker_container.nodered_container[*].name
  description = "The name of the container"
}