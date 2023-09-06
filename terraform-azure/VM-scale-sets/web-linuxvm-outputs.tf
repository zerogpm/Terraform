# Public IP Outputs
/*
## Public IP Address
output "web_linuxvm_public_ip" {
  description = "Web Linux VM Public Address"
  value = azurerm_public_ip.web_linuxvm_publicip.ip_address
}
*/

# Network Interface Outputs
## Network Interface ID
output "web_linuxvm_network_interface_id_list" {
  description = "Web Linux VM Network Interface ID"
  value = [for vm, nic in azurerm_network_interface.web_linuxvm_nic: nic.id]
}
## Network Interface Private IP Addresses
output "web_linuxvm_network_interface_ip_map" {
  description = "Web Linux VM Private IP Addresses"
  value = {for vm, nic in azurerm_network_interface.web_linuxvm_nic: vm => nic.private_ip_addresses}
}

# Linux VM Outputs
/*
## Virtual Machine Public IP
output "web_linuxvm_public_ip_address" {
  description = "Web Linux Virtual Machine Public IP"
  value = azurerm_linux_virtual_machine.web_linuxvm.public_ip_address
}
*/

## Virtual Machine Private IP
output "web_linuxvm_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value = {for vm in azurerm_linux_virtual_machine.web_linuxvm: vm.name => vm.private_ip_addresses}
}
## Virtual Machine 128-bit ID
output "web_linuxvm_virtual_machine_id_128bit" {
  description = "Web Linux Virtual Machine ID - 128-bit identifier"
  value = [for vm in azurerm_linux_virtual_machine.web_linuxvm: vm.virtual_machine_id]
}
## Virtual Machine ID
output "web_linuxvm_virtual_machine_id" {
  description = "Web Linux Virtual Machine ID "
  value = [for vm in azurerm_linux_virtual_machine.web_linuxvm: vm.id]
}