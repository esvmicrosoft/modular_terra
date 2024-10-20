

module machines {

  count = length(var.payg)

  source          = "../modules/machines/payg"
  depends_on      = [ 
                       module.myrg,
                       module.network,
                       module.stgacct
                    ]

  name            = "payg${count.index}"
  priv_ip         = cidrhost(module.network.subnets_cidrs[0], 6+count.index)
  nic_subnetid    = module.network.subnets_ids[0]

  pubip           = var.payg[count.index]["pubip"]
  publisher       = var.payg[count.index]["publisher"]
  offer           = var.payg[count.index]["offer"]
  sku             = var.payg[count.index]["sku"]
  image_version   = var.payg[count.index]["image_version"]

  custom_data    =  var.payg[count.index]["custom_data"]
#  keyvaultid      = azurerm_key_vault.diskencrypt.id
#  keyvaulturi     = azurerm_key_vault.diskencrypt.vault_uri
#  diskencryptkey  = azurerm_key_vault_key.diskencrypt.id
#  encrypt         = var.payg[count.index]["encrypt"]

  encrypt         = false


  storage_account = module.stgacct.blob_endpoint
  resource_group  = var.rg_name
  location        = var.location
}

