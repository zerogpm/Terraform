# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "terrafrom_resource_group" {
  name = "terrafrom-resource-group"
  location = "Canada Central"
}