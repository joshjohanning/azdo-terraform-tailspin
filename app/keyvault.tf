resource "azurerm_key_vault" "kv" {
  name                = var.key_vault
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = var.key_vault_tenant_id
  
  sku_name                        = "standard"
  # soft_delete_enabled             = true
  enabled_for_deployment          = true
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

resource "azurerm_key_vault_secret" "dbserverpw" {
  name         = "DB-Server-Password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault_access_policy.service_principal]
}