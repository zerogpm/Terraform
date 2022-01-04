resource "null_resource" "dockervol" {
  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
  }
}

resource "random_uuid" "random" {
  count = local.container_count
}

module "image" {
  source = "./image"
}

resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodered", terraform.workspace, random_uuid.random[count.index].result])
  image = module.image.image_out
  ports {
    internal = 1880
    external = var.external_port[terraform.workspace][count.index]
  }
  volumes {
    container_path = "/data"
    host_path = "${path.cwd}/noderedvol"
  }
}

