variable "image" {
  type = map
  description = "image for container"
  default = {
    nodered = {
      dev = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
  }
}

variable "external_port" {
  type        = map
  description = "description"
  
  validation {
    condition = max(var.external_port["dev"]...) <= 65535 && min(var.external_port["dev"]...) >= 1980
    error_message = "The internal port must be range."
  }

  validation {
    condition = max(var.external_port["prod"]...) <= 1980 && min(var.external_port["prod"]...) >= 1880
    error_message = "The internal port must be range."
  }
}

locals {
  container_count = length(var.external_port[terraform.workspace])
}

