provider "azurerm" {
  features {}
}

# when originally creating the tfstate resource group and resources, comment out this code. 
# after creating, re-run terraform init and terraform apply to switch the back-end
terraform {
  backend "azurerm" {
    resource_group_name   = "rg-tailspin-tfstate"
    storage_account_name  = "tailspintfstate"
    container_name        = "tfstate"
  }
}

resource "azurerm_resource_group" "tfstate" {
  name = "rg-tailspin-tfstate"
  location = "centralus"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tailspintfstate"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
