terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.52.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# remote state
# ===========================
terraform {
  backend "azurerm" {
    subscription_id      = "93ddb8b3-ddb9-4d1c-ba59-421456e65538"
    resource_group_name  = "rg-tailspin-tfstate"
    storage_account_name = "tailspintfstate"
    container_name       = "tfstate"
  }
}

# create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
}