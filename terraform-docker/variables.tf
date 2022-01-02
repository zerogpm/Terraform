variable "env" {
  type = string
  description = "Env to deploy to"
  default = "dev"
}

variable "image" {
  type = map
  description = "image for container"
  default = {
    dev = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "external_port" {
  type        = number
  description = "description"
  
  validation {
    condition = var.external_port <= 65535 && var.external_port > 0
    error_message = "The internal port must be range."
  }
}

variable "count_num" {
  type        = number
  default     = 1
  description = "description"
}