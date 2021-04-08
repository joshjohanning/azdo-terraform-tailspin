data "azurerm_subscription" "primary" {}

# can't use b/c in this tenant b/c no permissions
# # azure pipelines service principal
# data "azuread_service_principal" "azure_pipelines" {
#   display_name = var.azure_pipelines_spn
# }

# # my spn
# data "azuread_user" "my_upn" {
#   user_principal_name = "jjohanning@10thmagnitude.com"
# }