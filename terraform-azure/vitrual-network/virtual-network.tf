# Resource-2: Create Virtual Network
resource "azurerm_virtual_network" "ca_vnet" {
  name                = "VPC-CA-Central"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.terrafrom_resource_group.location
  resource_group_name = azurerm_resource_group.terrafrom_resource_group.name
  tags = {
    "Name" = "VPC-CA-Central"
    #"Environment" = "Dev"  # Uncomment during Step-10
  }
}

# Resource-3: Create Subnet
resource "azurerm_subnet" "mysubnet" {
  name                 = "subnet-public"
  resource_group_name  = azurerm_resource_group.terrafrom_resource_group.name
  virtual_network_name = azurerm_virtual_network.ca_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Resource-4: Create Public IP Address
resource "azurerm_public_ip" "mypublicip" {
  name                = "public-ip-1"
  resource_group_name = azurerm_resource_group.terrafrom_resource_group.name
  location            = azurerm_resource_group.terrafrom_resource_group.location
  allocation_method   = "Static"
  tags = {
    environment = "Dev"
  }
}

# Resource-5: Create Network Interface
resource "azurerm_network_interface" "myvmnic" {
  name                = "vmnic"
  location            = azurerm_resource_group.terrafrom_resource_group.location
  resource_group_name = azurerm_resource_group.terrafrom_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypublicip.id
  }
}