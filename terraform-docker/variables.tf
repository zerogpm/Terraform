variable "image" {
  type = map(any)
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
    grafana = {
      dev = "grafana/grafana-enterprise:8.2.0"
      prod = "grafana/grafana-enterprise:8.2.0"
    }
  }
}

variable "external_port" {
  type        = map(any)
  description = "description"
  
#  validation {
#    condition = max(var.external_port["dev"]...) <= 65535 && min(var.external_port["dev"]...) >= 1980
#    error_message = "The internal port must be range."
#  }
#
#  validation {
#    condition = max(var.external_port["prod"]...) <= 1980 && min(var.external_port["prod"]...) >= 1880
#    error_message = "The internal port must be range."
#  }
}

