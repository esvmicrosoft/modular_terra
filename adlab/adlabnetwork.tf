
module "windows_network" {
  source          = "../modules/network"
  depends_on      = [ module.myrg ]
  name            = "windows"
  location        = var.location
  resource_group  = var.rg_name
  cidr            = "10.0.0.0/16"
  cidr_bits       = var.cidr_bits
}

resource "azurerm_subnet_network_security_group_association" "windows_nsg_asocc" {
  depends_on = [ module.windows_network, module.myrg, azurerm_network_security_group.nsg ]
  count      = length(module.windows_network.subnets_ids)

  subnet_id                 = module.windows_network.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_virtual_network_peering" "windowsnetpeer" {
  name = "windowsnetpeer"
  depends_on = [ module.network, module.windows_network, module.myrg ]
  
  resource_group_name    = var.rg_name
  virtual_network_name   = module.windows_network.network_name
  remote_virtual_network_id  = module.network.network_id
}

resource "azurerm_virtual_network_peering" "networknetpeer" {
  name = "adlabnetpeer"
  depends_on = [ module.network, module.windows_network, module.myrg ]

  resource_group_name   = var.rg_name
  virtual_network_name   = module.network.network_name
  remote_virtual_network_id  = module.windows_network.network_id
}

