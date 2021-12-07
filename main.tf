# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.5.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = var.SUBSCRIPTION_ID
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
  tenant_id       = var.TENANT_ID
  features {}
}

resource "azurerm_resource_group" "terraform_rg" {
  name     = "Terraform-RG"
  location = "West Europe"
}

resource "azurerm_container_group" "example" {
  name                = "weatherapi"
  location            = azurerm_resource_group.terraform_rg.location
  resource_group_name = azurerm_resource_group.terraform_rg.name
  
  ip_address_type     = "public"
  dns_name_label      = "miweatherapi"
  os_type             = "Linux"

  container {
    name   = "weatherapi"
    image  = "vincenup/weatherapi"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

}

