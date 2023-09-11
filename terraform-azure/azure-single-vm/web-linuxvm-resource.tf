locals {
  webvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo apt update
sudo apt install nginx -y
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash && wait
sudo az storage blob download -c ${azurerm_storage_container.httpd_files_container.name} -f /var/www/html/data.json -n data.json --account-name ${azurerm_storage_account.storage_account.name} --account-key ${azurerm_storage_account.storage_account.primary_access_key}
sudo az storage blob download -c ${azurerm_storage_container.httpd_files_container.name} -f /etc/nginx/sites-available/backend.conf -n backend.conf --account-name ${azurerm_storage_account.storage_account.name} --account-key ${azurerm_storage_account.storage_account.primary_access_key}
sudo rm /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-available/default
sudo rm /var/www/html/index.nginx-debian.html
sudo ln -s /etc/nginx/sites-available/backend.conf /etc/nginx/sites-enabled/
sudo systemctl reload nginx
CUSTOM_DATA  
}

# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  name = "${local.resource_name_prefix}-web-linuxvm"
  #computer_name = "web-linux-vm" # Hostname of the VM (Optional)
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_DS1_v2"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.web_linuxvm_nic.id]

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
  #custom_data = filebase64("user-data.tpl")
  custom_data = base64encode(local.webvm_custom_data)
}

 resource "azurerm_managed_disk" "extended_disk" {
  name                 = "extend_disk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 40
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.extended_disk.id
  virtual_machine_id = azurerm_linux_virtual_machine.web_linuxvm.id
  lun                = "10"
  caching            = "ReadWrite"
  depends_on = [
    azurerm_linux_virtual_machine.web_linuxvm
  ]
} 

