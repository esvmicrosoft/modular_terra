
module "controller" {
  source = "../modules/machines/adc"
  depends_on = [
    module.myrg,
    module.windows_network
  ]

  server_name   = "controlleri"
  nic0_ip       = cidrhost(module.windows_network.subnets_cidrs[0], 5)
  nic0_subnetid = module.windows_network.subnets_ids[0]

  pubip         = true
  publisher     = "MicrosoftWindowsServer"
  offer         = "WindowsServer"
  sku           = "2025-datacenter-g2"
  image_version = "latest"

  userpassword = var.userpassword
  size         = "Standard_D2s_v4"

  storage_account = null
  resource_group  = var.rg_name
  location        = var.location
  adsetup         = false
}


module "jumphost" {
  source = "../modules/machines/payg"
  depends_on = [
    module.myrg,
    module.windows_network,
  ]

  name         = "jumphost"
  priv_index   = 6
  cidr_list    = module.windows_network.subnets_cidrs
  nic_subnetid = module.windows_network.subnets_ids

  pubip         = true
  publisher     = "canonical"
  offer         = "ubuntu-24_04-lts"
  sku           = "server"
  image_version = "latest"

  size = "Standard_D2s_v4"
  nics = 1

  encrypt = false

  storage_account = null
  resource_group  = var.rg_name
  location        = var.location

}

output "jumphostip" {
  value = "jumpserver IP ${module.jumphost.ip_address}"
}

output "windowsip" {
  value = "Windows Machine IP ${module.controller.ip_address}"
}

