

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "diskencrypt" {

  depends_on      = [ module.myrg ]
  name                = "${var.prefix}vault${random_id.randomId.hex}"
  location            = var.location
  resource_group_name = var.rg_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  enabled_for_disk_encryption     = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
  purge_protection_enabled        = false
  tags = {
     SecurityControl =  "Ignore"
  } 

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "3e201bd9-1a6d-4408-8277-62fc515ee4bc"

    key_permissions = ["Get", "List", "Create", "Recover", "Restore", "GetRotationPolicy", "SetRotationPolicy" ]
    secret_permissions = [ "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set" ]
  }

  access_policy {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = data.azurerm_client_config.current.object_id

      key_permissions = [
        "Get", "List", "Create", "Recover", "Restore", "GetRotationPolicy", "SetRotationPolicy" 
      ]

      secret_permissions = [ 
        "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set" 
      ]

      storage_permissions = []
    }
}

resource "azurerm_key_vault_key" "diskencrypt" {

  depends_on      = [ module.myrg ]
  name         = "diskEncryptionKey"
  key_vault_id = azurerm_key_vault.diskencrypt.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

#  rotation_policy {
#    automatic {
#      time_before_expiry = "P30D"
#    }
#
#    expire_after         = "P90D"
#    notify_before_expiry = "P29D"
#  }
}
