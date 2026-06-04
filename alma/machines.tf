

module machines {

  count = length(var.payg)

  source               = "../modules/machines/test"
  depends_on           = [ 
                           module.myrg,
                           module.static_network
                         ]

  name                 = "${var.payg[count.index]["name"]}"
  priv_ip              = cidrhost(module.static_network.subnets_cidrs[0], 6+count.index)
  nic_subnetid         = module.static_network.subnets_ids[0]

  pubip                = var.payg[count.index]["pubip"]
  publisher            = var.payg[count.index]["publisher"]
  offer                = var.payg[count.index]["offer"]
  sku                  = var.payg[count.index]["sku"]
  image_version        = var.payg[count.index]["image_version"]
  custom_data          = base64encode(file(var.payg[count.index]["custom_data"]))
  size                 = var.payg[count.index]["size"]
  network_acceleration = var.payg[count.index]["network_acceleration"]

#  avsetid             = ""

#  keyvaultid          = azurerm_key_vault.diskencrypt.id
#  keyvaulturi         = azurerm_key_vault.diskencrypt.vault_uri
#  diskencryptkey      = azurerm_key_vault_key.diskencrypt.id
  encrypt             = var.payg[count.index]["encrypt"]

  resource_group      = var.rg_name
  location            = var.location
}


output "ips" {
  value = [ module.machines[*].ip_address ]
}
