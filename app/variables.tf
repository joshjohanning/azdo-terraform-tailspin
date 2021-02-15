variable "resource_group" {
  description = "Resource group name"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
}

variable "app_service_plan" {
  description = "The app service plan to create"
}

variable "app_service" {
  description = "The app service to create that uses the app service plan"
}

variable "app_service_slot" {
  description = "The swap slot to create"
}

variable "key_vault" {
  description = "The key vault to create to store app secrets"
}

variable "key_vault_tenant_id" {
  description = "The active directory used to verify kv access"
}

variable "key_vault_spn_object_id" {
  description = "the spn client id for the key vault policy"
}

variable "key_vault_my_object_id" {
  description = "my client id for the key vault policy"
}

variable "database_server_name" {
  description = "database server name"
}

variable "database_name" {
  description = "database server name"
}

variable "sql_firewall_rules" {
  default = {
    # 0.0.0.0 is the allow all azure services - see: https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/createorupdate
    "AllowAllWindowsAzureIps" = {
      "ip" = "0.0.0.0"
    }
  }
}