provider "azurerm" {
  subscription_id = "49b7-ddlad-dldaddl-mndc9"
  client_id       = "1b43b-adnasd-ndnel58aa"
  client_secret   = "IVcjwqehw-lkkcbj-kdsakjkh"
  tenant_id       = "52d0d-akdakdvhhj-hkj1"
}

resource "azurerm_resource_group" "firstproject" {
  name     = "MYTF-RG845"
  location = "eastus2"
  tags = {
    "terraform" = "terraform"
  }
}

resource "azurerm_virtual_network" "firstproject" {
  name                = "mytf-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.firstproject.location
  resource_group_name = azurerm_resource_group.firstproject.name
}

resource "azurerm_subnet" "firstproject" {
  name                 = "mytf-subnet"
  resource_group_name  = azurerm_resource_group.firstproject.name
  virtual_network_name = azurerm_virtual_network.firstproject.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "firstproject" {
  name                = "mytf-nic"
  location            = azurerm_resource_group.firstproject.location
  resource_group_name = azurerm_resource_group.firstproject.name

  ip_configuration {
    name                          = "mytf-ipconfig"
    subnet_id                     = azurerm_subnet.firstproject.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "firstproject" {
  name                  = "mytf-vm"
  location              = azurerm_resource_group.firstproject.location
  resource_group_name   = azurerm_resource_group.firstproject.name
  network_interface_ids = [azurerm_network_interface.firstproject.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "mytf-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "mytf-vm"
    admin_username = " "
    admin_password = " "
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_log_analytics_workspace" "firstproject" {
  name                = "mytf-law"
  location            = azurerm_resource_group.firstproject.location
  resource_group_name = azurerm_resource_group.firstproject.name
  sku                 = "PerGB2018"
}

resource "azurerm_storage_account" "firstproject" {
  name                     = "mytfstorageacct"
  resource_group_name      = azurerm_resource_group.firstproject.name
  location                 = azurerm_resource_group.firstproject.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_container_registry" "firstproject" {
  name                = "mytfacr"
  location            = azurerm_resource_group.firstproject.location
  resource_group_name = azurerm_resource_group.firstproject.name
}