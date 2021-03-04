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

variable "kv_service_principals" {
  description = "objects to add to key vault access policy"
  default = {
    "azdo-spn" = {
      "object_id" = "4ded4b3b-26a7-4ea4-a166-d33f49d8a0d3"
    },
    "my-spn" = {
      "object_id" = "dfd708fe-1a12-48ee-9784-26933e4d7f14"
    }
  }
}

variable "database_server_name" {
  description = "database server name"
}

variable "database_name" {
  description = "database server name"
}

variable "sql_firewall_rules" {
  description = "the sql firewall rules to add to db server"
  default = {
    # 0.0.0.0 is the allow all azure services - see: https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/createorupdate
    "AllowAllWindowsAzureIps" = {
      "ip" = "0.0.0.0"
    }
  }
}