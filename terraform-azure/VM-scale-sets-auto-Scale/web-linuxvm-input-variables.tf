# Linux VM Input Variables Placeholder file.


# Web LB Inbout NAT Port for All VMs
variable "web_linuxvm_instance_count" {
  description = "Web linux vm count"
  type        = map(string)
  default = {
    "vm1" : "1022"
    "vm2" : "2022"
  }
}