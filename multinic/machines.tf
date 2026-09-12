

module "machines" {

  count = length(var.payg)

  source = "../modules/machines/payg"
  depends_on = [
    module.myrg,
    module.static_network
  ]

  provided     = 20260601
  name         = var.payg[count.index]["name"]
  priv_index   = count.index + 6
  cidr_list    = module.static_network.subnets_cidrs
  nic_subnetid = module.static_network.subnets_ids

  pubip                = var.payg[count.index]["pubip"]
  publisher            = var.payg[count.index]["publisher"]
  offer                = var.payg[count.index]["offer"]
  sku                  = var.payg[count.index]["sku"]
  image_version        = var.payg[count.index]["image_version"]
  custom_data          = base64encode(file("${path.module}/${var.payg[count.index]["custom_data"]}"))
  size                 = var.payg[count.index]["size"]
  network_acceleration = var.payg[count.index]["network_acceleration"]
  nics                 = var.payg[count.index]["nics"]

  #  avsetid             = ""
  #  keyvaultid          = azurerm_key_vault.diskencrypt.id
  #  keyvaulturi         = azurerm_key_vault.diskencrypt.vault_uri
  #  diskencryptkey      = azurerm_key_vault_key.diskencrypt.id
  #  encrypt             = var.payg[count.index]["encrypt"]


  resource_group = var.rg_name
  location       = var.location
}


output "ips" {
  value = [module.machines[*].ip_address]
}
