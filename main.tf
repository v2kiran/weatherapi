terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.85.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tf_rg_storage"
    storage_account_name = "tfstatestore001"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

variable "imagebuild" {
  type = string
  description = "Latest Image Build"

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
  dns_name_label  = "kiranblazorapp"
  os_type         = "linux"

  container {
    name   = "blazorapp"
    image  = "v2kiran/blazorapp:latest:${var.imagebuild}"
    cpu    = "1"
    memory = "1"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
