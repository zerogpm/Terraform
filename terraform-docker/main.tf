locals {
  deployment = {
    nodered = {
      image = var.image["nodered"][terraform.workspace]
    }
    influxdb = {
      image = var.image["influxdb"][terraform.workspace]
    }
  }
}

resource "random_uuid" "random" {
  count = local.container_count
}

module "image" {
  source = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  source = "./container"
  count = local.container_count
  name_in = join("-", ["nodered", terraform.workspace, random_uuid.random[count.index].result])
  image_in = module.image["nodered"].image_out
  int_port_in = 1880
  ext_port_in = var.external_port[terraform.workspace][count.index]
  container_path_in = "/data"
}

