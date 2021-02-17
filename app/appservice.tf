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
