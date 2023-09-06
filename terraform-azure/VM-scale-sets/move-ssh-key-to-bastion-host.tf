# Create a Null Resource and Provisioners
resource "null_resource" "null_copy_ssh_key_to_bastion" {
  depends_on = [azurerm_linux_virtual_machine.bastion_host_linuxvm]
  # Connection Block for Provisioners to connect to Azure VM Instance
  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    user        = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    private_key = file("~/.ssh/id_rsa")
  }
  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "~/.ssh/id_rsa"
    destination = "/tmp/id_rsa"
  }
  ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/id_rsa"
    ]
  }
}