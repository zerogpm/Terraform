variable "web_vmss_nsg_inbound_ports" {
  description = "Web VMSS NSG Inbound Ports"
  type        = list(string)
  default     = [22, 80, 443]
}

variable "web_monitor_autoscale_setting_email" {
  description = "mon itoremail"
  type        = string
  default     = "test@gmail.com"
}