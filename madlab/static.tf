
module "controller25" {
    source                   = "../modules/machines/adc"
    depends_on               = [
                                 module.myrg,
                                 module.static_network
                               ]

    server_name              = "controller25"
    nic0_ip                  = cidrhost(module.static_network.subnets_cidrs[0], 5)
    nic0_subnetid            = module.static_network.subnets_ids[0]

    pubip                    = true
    publisher                = "MicrosoftWindowsServer"
    offer                    = "WindowsServer"
    sku                      = "2025-datacenter-g2"
    image_version            = "latest"

    userpassword             = var.userpassword

    size                     = "Standard_D4s_v4"

    resource_group           = var.rg_name
    storage_account          = null
    location                 = var.location
    adsetup                  = true
    custom_domain            = "CONTOSOII.COM"

}

module "controller22" {
    source                   = "../modules/machines/adc"
    depends_on               = [
                                 module.myrg,
                                 module.static_network
                               ]

    server_name              = "controller22"
    nic0_ip                  = cidrhost(module.static_network.subnets_cidrs[0], 6)
    nic0_subnetid            = module.static_network.subnets_ids[0]

    pubip                    = true
    publisher                = "MicrosoftWindowsServer"
    offer                    = "WindowsServer"
    sku                      = "2022-datacenter-g2"
    image_version            = "latest"

    userpassword             = var.userpassword

    size                     = "Standard_D4s_v4"

    storage_account          = null
    resource_group           = var.rg_name
    location                 = var.location
    adsetup                  = true
    custom_domain            = "CONTOSOI.COM"

}


module "jumphost" {
  source               = "../modules/machines/payg"
  depends_on           = [
                           module.myrg,
                           module.static_network,
                         ]

  name                 = "jumphost"
  priv_ip              = cidrhost(module.static_network.subnets_cidrs[0], 7)
  nic_subnetid         = module.static_network.subnets_ids[0]

  pubip                = true
  publisher            = "canonical"
  offer                = "ubuntu-24_04-lts"
  sku                  = "server"
  image_version        = "latest"

  size                 = "Standard_D2s_v4"

  encrypt              = false

  storage_account     = null
  resource_group      = var.rg_name
  location            = var.location

}

output "jumphostip" {
  value = "jumpserver IP ${module.jumphost.ip_address}"
}
