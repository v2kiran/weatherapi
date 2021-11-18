terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.85.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
  name     = "tfmainrg"
  location = "North Central US"
}

resource "azurerm_container_group" "tfcg_test" {
  name                = "blazorapp"
  location            = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type = "public"
  dns_name_label = "kiranblazorapp"
  os_type = "linux"

  container {
    name = "blazorapp"
    image = "v2kiran/blazorapp:latest"
    cpu = "1"
    memory = "1"
    ports {
      port = 80
      protocol = "TCP"
    }
  }
}