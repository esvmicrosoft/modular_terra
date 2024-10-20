
resource "azurerm_resource_group" "rg" {
  name     = var.name 
  location = var.location
}

output "rg" {
  value = azurerm_resource_group.rg
}
