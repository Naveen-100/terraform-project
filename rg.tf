resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.resource_group_location
}