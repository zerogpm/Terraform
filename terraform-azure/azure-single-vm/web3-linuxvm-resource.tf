# # Resource: Azure Linux Virtual Machine
# resource "azurerm_linux_virtual_machine" "web_linuxvm-3" {
#   name = "${local.resource_name_prefix}-web-3-linuxvm"
#   #computer_name = "web-linux-vm" # Hostname of the VM (Optional)
#   resource_group_name   = azurerm_resource_group.rg.name
#   location              = azurerm_resource_group.rg.location
#   size                  = "Standard_DS1_v2"
#   admin_username        = "azureuser"
#   network_interface_ids = [ azurerm_network_interface.web_linuxvm_nic_3.id ]
  
#   admin_ssh_key {
#     username   = "azureuser"
#     public_key = file("~/.ssh/remote-key.pub")
#   }
#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts-gen2"
#     version   = "20.04.202106030"
#   }
# }

# resource "azurerm_managed_disk" "extended_disk_3" {
#   name                 = "extend_disk_3"
#   location             = azurerm_resource_group.rg.location
#   resource_group_name  = azurerm_resource_group.rg.name
#   storage_account_type = "Standard_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = 40
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment_3" {
#   managed_disk_id    = azurerm_managed_disk.extended_disk_3.id
#   virtual_machine_id = azurerm_linux_virtual_machine.web_linuxvm-3.id
#   lun                = "10"
#   caching            = "ReadWrite"
#   depends_on = [
#     azurerm_linux_virtual_machine.web_linuxvm
#   ]
# }