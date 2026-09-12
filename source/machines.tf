

module "payg" {

  count = length(var.payg)

  source = "../modules/machines/payg"
  depends_on = [
    module.myrg,
    module.network
  ]

  provided     = 20260601
  name         = var.payg[count.index]["name"]
  priv_index   = count.index + 6
  cidr_list    = module.network.subnets_cidrs
  nic_subnetid = module.network.subnets_ids

  pubip                = var.payg[count.index]["pubip"]
  publisher            = var.payg[count.index]["publisher"]
  offer                = var.payg[count.index]["offer"]
  sku                  = var.payg[count.index]["sku"]
  image_version        = var.payg[count.index]["image_version"]
  custom_data          = base64encode(file("${path.module}/${var.payg[count.index]["custom_data"]}"))
  size                 = var.payg[count.index]["size"]
  network_acceleration = var.payg[count.index]["network_acceleration"]
  nics                 = var.payg[count.index]["nics"]
  disk_controller_type = var.payg[count.index]["nvme"]

  #  avsetid             = ""
  encrypt = var.payg[count.index]["encrypt"]

  #  keyvaultid          = var.payg[count.index]["encrypt"] ? azurerm_key_vault.diskencrypt.id : null
  #  keyvaulturi         = var.payg[count.index]["encrypt"] ? azurerm_key_vault.diskencrypt.vault_uri : null
  #  diskencryptkey      = var.payg[count.index]["encrypt"] ? azurerm_key_vault_key.diskencrypt.id : null

  resource_group = var.rg_name
  location       = var.location
}

module "byos" {

  count = length(var.byos)

  source = "../modules/machines/byos"
  depends_on = [
    module.myrg,
    module.network
  ]
  name         = var.byos[count.index]["name"]
  priv_ip      = cidrhost(module.network.subnets_cidrs[0], 6 + length(var.payg) + count.index)
  nic_subnetid = module.network.subnets_ids[0]

  pubip                = var.byos[count.index]["pubip"]
  publisher            = var.byos[count.index]["publisher"]
  offer                = var.byos[count.index]["offer"]
  sku                  = var.byos[count.index]["sku"]
  image_version        = var.byos[count.index]["image_version"]
  custom_data          = base64encode(file("${path.module}/${var.byos[count.index]["custom_data"]}"))
  size                 = var.byos[count.index]["size"]
  network_acceleration = var.byos[count.index]["network_acceleration"]

  #  avsetid             = ""
  #  keyvaultid          = azurerm_key_vault.diskencrypt.id
  #  keyvaulturi         = azurerm_key_vault.diskencrypt.vault_uri
  #  diskencryptkey      = azurerm_key_vault_key.diskencrypt.id
  #  encrypt             = var.byos[count.index]["encrypt"]

  encrypt = false


  resource_group = var.rg_name
  location       = var.location
}

output "paygips" {
  value = [module.payg[*].ip_address]
}

output "byosips" {
  value = [module.byos[*].ip_address]
}
