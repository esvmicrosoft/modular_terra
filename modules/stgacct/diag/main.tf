

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "diagstg" {
  name                     = var.name
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action   = "Deny"
    ip_rules = var.allowed_ips
  }
}

output "bootdiag" {
  value = azurerm_storage_account.diagstg.primary_blob_endpoint
}
