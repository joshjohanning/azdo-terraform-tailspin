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