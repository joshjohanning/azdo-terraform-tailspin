data "azurerm_resource_group" "bacpacstorage" {
  name     = "stgacctcliRG"
}

data "azurerm_storage_account" "bacpacstorage" {
  name                     = "stgacctcli24"
  resource_group_name      = data.azurerm_resource_group.bacpacstorage.name
}

data "azurerm_storage_container" "bacpacstorage" {
  name                 = "container1"
  storage_account_name = data.azurerm_storage_account.bacpacstorage.name
}

data "azurerm_storage_account_blob_container_sas" "bacpacstorage" {
  connection_string = data.azurerm_storage_account.bacpacstorage.primary_connection_string
  container_name    = data.azurerm_storage_container.bacpacstorage.name
  https_only        = true

  start  = "2021-02-15"
  expiry = "2022-02-15"

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = false
  }
}

# output "sas_url_query_string" {
#   value = data.azurerm_storage_account_blob_container_sas.bacpacstorage.sas
# }
