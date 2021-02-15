resource "random_password" "password" {
  length = 12
  special = true
  override_special = "_%@"
}

resource "azurerm_mssql_server" "server" {
  name                         = var.database_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "joshadmin"
  administrator_login_password = random_password.password.result
  minimum_tls_version          = "1.2"
  tags = {
    environment = terraform.workspace
  }

  # azuread_administrator {
  #   login_username = var.azuread_administrator_login_username
  #   object_id      = var.azuread_administrator_object_id
  #   tenant_id      = var.azuread_administrator_tenant_id
  # }
}

resource "azurerm_mssql_database" "db" {
  name           = var.database_name
  server_id      = azurerm_mssql_server.server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  read_scale     = false
  sku_name       = "Basic"
  zone_redundant = false

}
resource "azurerm_sql_firewall_rule" "rules" {
  count               = length(var.sql_firewall_rules)
  name                = element(keys(var.sql_firewall_rules), count.index)
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mssql_server.server.name
  start_ip_address    = var.sql_firewall_rules[element(keys(var.sql_firewall_rules), count.index)]["ip"]
  end_ip_address      = var.sql_firewall_rules[element(keys(var.sql_firewall_rules), count.index)]["ip"]
}
