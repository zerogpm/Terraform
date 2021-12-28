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
  count = var.count_num
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  count = var.count_num
  name  = join("-", ["nodered", random_uuid.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = var.external_port
  }
}