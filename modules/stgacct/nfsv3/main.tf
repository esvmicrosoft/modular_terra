

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "stgacct" {
  name                     = var.name
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
  nfsv3_enabled            = true

  network_rules {
    default_action   = "Deny"
    ip_rules = var.allowed_ips
  }
}

output "blob_endpoint" {
  value = azurerm_storage_account.stgacct.primary_blob_endpoint
}
