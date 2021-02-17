resource "random_password" "password" {
  length           = 16
  special          = true
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  min_lower        = 1
  override_special = "!"
}

resource "azurerm_sql_server" "server" {
  name                         = var.database_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "joshadmin"
  administrator_login_password = random_password.password.result
}

resource "azurerm_sql_database" "db" {
  name                = var.database_name
  server_name         = azurerm_sql_server.server.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  max_size_bytes      = 1073741824 # 1 gb

  import {
    storage_uri                  = "https://stgacctcli24.blob.core.windows.net/container1/tailspindatabase.bacpac"
    storage_key                  = data.azurerm_storage_account_blob_container_sas.bacpacstorage.sas
    storage_key_type             = "SharedAccessKey"
    administrator_login          = azurerm_sql_server.server.administrator_login
    administrator_login_password = random_password.password.result
    authentication_type          = "SQL"
  }

}
resource "azurerm_sql_firewall_rule" "rules" {
  count               = length(var.sql_firewall_rules)
  name                = element(keys(var.sql_firewall_rules), count.index)
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_sql_server.server.name
  start_ip_address    = var.sql_firewall_rules[element(keys(var.sql_firewall_rules), count.index)]["ip"]
  end_ip_address      = var.sql_firewall_rules[element(keys(var.sql_firewall_rules), count.index)]["ip"]
}
