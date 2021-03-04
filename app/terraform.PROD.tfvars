location = "centralus"

resource_group = "rg-tailspin-terraform-PROD"

app_service_plan = "asp-tailspin-PROD"

app_service = "app-tailspin-PROD"

app_service_slot = "swap"

key_vault = "kv-tailspin-PROD"

key_vault_tenant_id = "6660b467-add3-4d9e-8ada-48b1721959f3"

kv_service_principals = {
  "azdo-spn" = {
    "object_id" = "4ded4b3b-26a7-4ea4-a166-d33f49d8a0d3"
  },
  "my-spn" = {
    "object_id" = "dfd708fe-1a12-48ee-9784-26933e4d7f14"
  }
}

database_server_name = "tailspinjosh-server-dev"

database_name = "tailspinjosh-db-dev"