# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine_scale_set" "web_vmss" {
  name = "${local.resource_name_prefix}-web-vmss"
  #computer_name = "web-linux-vm" # Hostname of the VM (Optional)
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  sku                   = "Standard_DS1_v2"
  instances             = 1
  admin_username        = "azureuser"
  #network_interface_ids = [ azurerm_network_interface.web_linuxvm_nic.id ]
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy-daily"
    sku       = "22_04-daily-lts-gen2"
    version   = "22.04.202309030"
  }
  #custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")
  custom_data = filebase64("user-data.tpl")

  upgrade_mode = "Automatic"

  network_interface {
    name = "web-vmss-nic"
    primary = "true"
    network_security_group_id = azurerm_network_security_group.web_vmss_nsg.id
    ip_configuration {
      name = "internal"
      primary = true
      subnet_id = azurerm_subnet.websubnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id]
    }
  }
}

/* resource "azurerm_managed_disk" "extended_disk" {
  for_each             = var.web_linuxvm_instance_count
  name                 = "extned_disk-${each.key}"
  resouxrce_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 40
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachement" {
  for_each           = var.web_linuxvm_instance_count
  managed_disk_id    = azurerm_managed_disk.extended_disk[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.web_linuxvm[each.key].id
  lun                = "10"
  caching            = "ReadWrite"
  depends_on         = [azurerm_linux_virtual_machine_scale_set.web_vmss]
} */