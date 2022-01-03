terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {}

resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
  }
}

resource "random_uuid" "random" {
  count = local.container_count
}

resource "docker_image" "nodered_image" {
  name = lookup(var.image, var.env)
}

resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", random_uuid.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = var.external_port[count.index]
  }
  volumes {
    container_path = "/data"
    host_path = "${path.cwd}/noderedvol"
  }
}

