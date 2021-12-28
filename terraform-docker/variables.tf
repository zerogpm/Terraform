variable "external_port" {
  type        = number
  default     = 1880
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