provider "azurerm" {
  features {}
}

# remote state
# ===========================
terraform {
  backend "azurerm" {
    subscription_id       = "93ddb8b3-ddb9-4d1c-ba59-421456e65538"
    resource_group_name   = "rg-tailspin-tfstate"
    storage_account_name  = "tailspintfstate"
    container_name        = "tfstate"
  }
}

# create resource group
resource "azurerm_resource_group" "rg"{
    name = var.resource_group
    location = var.location
}

# creates app service plan
resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = var.app_service
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version         = "DOTNETCORE|3.1"
    remote_debugging_enabled = false
    remote_debugging_version = "VS2019"
    http2_enabled            = true
    always_on                = true
  }
}

resource "azurerm_app_service_slot" "slotDemo" {
    name                = var.app_service_slot
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    app_service_plan_id = azurerm_app_service_plan.asp.id
    app_service_name    = azurerm_app_service.app.name

    site_config {
      linux_fx_version         = "DOTNETCORE|3.1"
      remote_debugging_enabled = false
      remote_debugging_version = "VS2019"
      http2_enabled            = true
      always_on                = true
    }
}

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = var.key_vault_tenant_id
  
  sku_name                        = "standard"
  soft_delete_enabled             = true
  enabled_for_deployment          = false
  enabled_for_template_deployment = false
  enabled_for_disk_encryption     = false
}

resource "azurerm_key_vault_access_policy" "service_principal" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.key_vault_tenant_id
  object_id = var.key_vault_spn_object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]
}

resource "azurerm_key_vault_access_policy" "my" {
  key_vault_id = azurerm_key_vault.kv.id

  tenant_id = var.key_vault_tenant_id
  object_id = var.key_vault_my_object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete"
  ]
}

resource "azurerm_key_vault_secret" "applicationInsightsKey" {
  name         = "ApplicationInsightsKey"
  value        = "-test-"
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}