# App default DNS Name
variable "naked_app_dns_name" {
  description = "App DNS Name"
  type        = string
  default     = "devopeasyway.com"
}

variable "nlb_dns_name" {
  description = "App DNS Name"
  type        = string
  default     = "cloudwatch.devopeasyway.com"
}