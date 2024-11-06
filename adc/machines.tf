
module "controller" {
    source          = "../modules/machines/adc"
    depends_on      = [
                        module.myrg,
                        module.windows_network
                      ]
    server_name     = "controller"

    nic0_ip                  = cidrhost(module.windows_network.subnets_cidrs[0], 4)
    nic0_subnetid            = module.windows_network.subnets_ids[0]
    pubip                    = true
    userpassword             = var.userpassword
    adsetup                  = true

    storage_account = module.stgacct.bootdiag
    resource_group  = var.rg_name
    location        = var.location
}

module "jumphost" {
    source          = "../modules/machines/payg"
    depends_on      = [
                        module.myrg,
                        module.linux_network
                      ]
    name            = "jumphost"

    priv_ip         = cidrhost(module.linux_network.subnets_cidrs[0], 4)
    nic_subnetid    = module.linux_network.subnets_ids[0]
    pubip           = true
    
    publisher       = "canonical" 
    offer           = "0001-com-ubuntu-server-jammy"
    sku             = "22_04-lts"
    image_version   = "latest"

    custom_data    =  "/dev/null"

    storage_account = module.stgacct.bootdiag
    resource_group  = var.rg_name
    location        = var.location
}

module "machines" {

  count = length(var.payg)

  source          = "../modules/machines/payg"
  depends_on      = [ 
                       module.myrg,
                       module.linux_network,
                       module.stgacct
                    ]

  name            = "${var.payg[count.index]["name"]}${count.index}"
  priv_ip         = cidrhost(module.linux_network.subnets_cidrs[0], 6+count.index)
  nic_subnetid    = module.linux_network.subnets_ids[0]

  pubip           = false
  publisher       = var.payg[count.index]["publisher"]
  offer           = var.payg[count.index]["offer"]
  sku             = var.payg[count.index]["sku"]
  image_version   = var.payg[count.index]["image_version"]

  custom_data    =  var.payg[count.index]["custom_data"]

  dns_server     = [ module.controller.priv_address ]

#  avsetid         = ""

#  keyvaultid      = azurerm_key_vault.diskencrypt.id
#  keyvaulturi     = azurerm_key_vault.diskencrypt.vault_uri
#  diskencryptkey  = azurerm_key_vault_key.diskencrypt.id
#  encrypt         = var.payg[count.index]["encrypt"]

  encrypt         = false


  storage_account = module.stgacct.bootdiag
  resource_group  = var.rg_name
  location        = var.location
}

