// This is a terraform block. 

terraform {
  required_version = "1.0.11"

}

// This is Provider's block
provider "azurerm" {
  features {}
  client_id       = "6a3baa3e-0d7c-4805-8496-da0e24b93510"
  client_secret   = "giA7Q~vkA5PmuCMHUSEV2TDPuSe9mKzxQvYmw"
  tenant_id       = "051173eb-ee17-4e41-8995-f56af1cee886"
  subscription_id = "6ed44b8b-06a3-4f16-8837-b21409d5dad6"
}

resource "azurerm_resource_group" "testrg" {
  name     = "testrg"
  location = "westus"
}

resource "azurerm_virtual_network" "testvnet" {
  name                = "testvnet"
  location            = "westus"
  resource_group_name = azurerm_resource_group.testrg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.testvnet.name
  resource_group_name  = azurerm_resource_group.testrg.name
}

resource "azurerm_network_interface" "testnic1" {
  name                = "webnic"
  location            = azurerm_resource_group.testrg.location
  resource_group_name = azurerm_resource_group.testrg.name

  ip_configuration {
    name                          = "mywebipconfig"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    //public_ip_address_id          = azurerm_public_ip.mypip1.id
  }
}
