resource "random_uuid" "random" {
  count = var.count_in
}

resource "docker_container" "app_container" {
  count = var.count_in
  name  = join("-", [var.name_in, terraform.workspace, random_uuid.random[count.index].result])
  image = var.image_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = docker_volume.container_volume[volumes.key].name
    }
  }
}

resource "docker_volume" "container_volume" {
  count = length(var.volumes_in)
  name  = "${var.name_in}-${count.index}-volume"
  lifecycle {
    prevent_destroy = false
  }
  #  provisioner "local-exec" {
  #    when       = destroy
  #    command    = "mkdir ${path.cwd}/../backup/"
  #    on_failure = continue
  #  }
  #  provisioner "local-exec" {
  #    when       = destroy
  #    command    = "sudo tar -czvf ${path.cwd}/../backup/${self.name}.tar.gz ${self.mountpoint}/"
  #    on_failure = fail
  #  }
}
