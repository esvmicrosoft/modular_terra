 

module payg {

  count = length(var.payg)

  source               = "../modules/machines/payg"
  depends_on           = [ 
                           module.myrg,
                           module.adlab_network
                         ]

  name                 = "${var.payg[count.index]["name"]}"
  priv_ip              = cidrhost(module.adlab_network.subnets_cidrs[0], 6+count.index)
  nic_subnetid         = module.adlab_network.subnets_ids[0]

  pubip                = var.payg[count.index]["pubip"]
  publisher            = var.payg[count.index]["publisher"]
  offer                = var.payg[count.index]["offer"]
  sku                  = var.payg[count.index]["sku"]
  image_version        = var.payg[count.index]["image_version"]
  custom_data          = base64encode(file("${path.module}/${var.payg[count.index]["custom_data"]}"))
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

### module byos {
### 
###   count = length(var.byos)
### 
###   source               = "../modules/machines/byos"
###   depends_on           = [ 
###                           module.myrg,
###                           module.adlab_network
###                        ]
### 
###   name                 = "${var.byos[count.index]["name"]}"
###   priv_ip              = cidrhost(module.adlab_network.subnets_cidrs[0], 6+length(var.payg)+count.index)
###   nic_subnetid         = module.adlab_network.subnets_ids[0]
### 
###   pubip                = var.byos[count.index]["pubip"]
###   publisher            = var.byos[count.index]["publisher"]
###   offer                = var.byos[count.index]["offer"]
###   sku                  = var.byos[count.index]["sku"]
###   image_version        = var.byos[count.index]["image_version"]
###   custom_data          = base64encode(file("${path.module}/${var.byos[count.index]["custom_data"]}"))
###   size                 = var.byos[count.index]["size"]
###   network_acceleration = var.byos[count.index]["network_acceleration"]
### 
### #  avsetid         = ""
### #  keyvaultid      = azurerm_key_vault.diskencrypt.id
### #  keyvaulturi     = azurerm_key_vault.diskencrypt.vault_uri
### #  diskencryptkey  = azurerm_key_vault_key.diskencrypt.id
### #  encrypt         = var.byos[count.index]["encrypt"]
### 
###   encrypt              = false
### 
### 
###   storage_account      = null
###   resource_group       = var.rg_name
###   location             = var.location
### }

output "paygips" {
  value = [ module.payg[*].ip_address ]
}

### output "byosips" {
###   value = [ module.byos[*].ip_address ]
### }
