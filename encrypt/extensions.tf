resource "azurerm_virtual_machine_extension" "bootstrap" {

  #   count = length(var.payg)
  count = 0

  name                 = "bootstrap_extension"
  virtual_machine_id   = module.payg[count.index].machine.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
      "commandToExecute":   "while [ ! -f /data/extension_is_done ]; do sleep 30; done; touch /data/extensions_checked"
    }
  SETTINGS

  # depends_on = [ module.payg ]
  # depends_on   = [ azurerm_virtual_machine_data_disk_attachment.datadisk_attachment ]
}

resource "azurerm_virtual_machine_extension" "linux_ade" {

  count = length(var.payg)

  #name    = "Microsoft.Azure.Security.AzureDiskEncryptionForLinux"
  name                       = "AzureDiskEncryptionForLinux"
  virtual_machine_id         = module.payg[count.index].machine.id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "AzureDiskEncryptionForLinux"
  type_handler_version       = "1.1"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
  {
      "EncryptionOperation"   : "EnableEncryption",
      "KeyVaultURL"           : "${azurerm_key_vault.diskencrypt.vault_uri}",
      "KeyEncryptionKeyURL"   : "${azurerm_key_vault_key.diskencrypt.id}",

      "KeyVaultResourceId"    : "${azurerm_key_vault.diskencrypt.id}",
      "KekVaultResourceId"    : "${azurerm_key_vault.diskencrypt.id}",

      "KeyEncryptionAlgorithm" : "RSA-OAEP",
      "VolumeType"             : "ALL"
  }
  SETTINGS

  depends_on = [
    module.payg,
    azurerm_key_vault.diskencrypt,
    azurerm_private_endpoint.pep,
    azurerm_virtual_machine_extension.bootstrap
  ]
  #                   azurerm_virtual_machine_data_disk_attachment.datadisk_attachment,
}
