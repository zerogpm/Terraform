locals {
  deployment = {
    nodered = {
      image = var.image["nodered"][terraform.workspace]
      int = 1880
      ext = var.external_port["nodered"][terraform.workspace]
      container_path = "/data"
    }
    influxdb = {
      image = var.image["influxdb"][terraform.workspace]
      int = 8086
      ext = var.external_port["influxdb"][terraform.workspace]
      container_path = "/var/lib/influxdb"
    }
  }
}

resource "random_uuid" "random" {
  for_each = local.deployment
}

module "image" {
  source = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  source = "./container"
  for_each = local.deployment
  name_in = join("-", [each.key, terraform.workspace, random_uuid.random[each.key].result])
  image_in = module.image[each.key].image_out
  int_port_in = each.value.int
  ext_port_in = each.value.ext[0]
  container_path_in = each.value.container_path
}

