
module "network0" {
  source         = "../modules/network"
  depends_on     = [module.myrg]
  name           = "network0"
  location       = var.location
  resource_group = var.rg_name
  cidr           = "10.0.0.0/16"
  cidr_bits      = var.cidr_bits
}

module "network1" {
  source         = "../modules/network"
  depends_on     = [module.myrg]
  name           = "network1"
  location       = var.location
  resource_group = var.rg_name
  cidr           = "10.1.0.0/16"
  cidr_bits      = var.cidr_bits
}

module "network2" {
  source         = "../modules/network"
  depends_on     = [module.myrg]
  name           = "adlab"
  location       = var.location
  resource_group = var.rg_name
  cidr           = "10.2.0.0/16"
  cidr_bits      = var.cidr_bits
}

resource "azurerm_virtual_network_peering" "peer01" {
  name       = "staticnnetpeer"
  depends_on = [module.network0, module.network1, module.myrg]

  resource_group_name       = var.rg_name
  virtual_network_name      = module.network0.network_name
  remote_virtual_network_id = module.network1.network_id
}

resource "azurerm_virtual_network_peering" "peer10" {
  name       = "adlabnetpeer"
  depends_on = [module.network0, module.network1, module.myrg]

  resource_group_name       = var.rg_name
  virtual_network_name      = module.network1.network_name
  remote_virtual_network_id = module.network0.network_id
}

resource "azurerm_virtual_network_peering" "peer02" {
  name       = "staticnnetpeer"
  depends_on = [module.network0, module.network2, module.myrg]

  resource_group_name       = var.rg_name
  virtual_network_name      = module.network0.network_name
  remote_virtual_network_id = module.network2.network_id
}

resource "azurerm_virtual_network_peering" "peer20" {
  name       = "adlabnetpeer"
  depends_on = [module.network0, module.network2, module.myrg]

  resource_group_name       = var.rg_name
  virtual_network_name      = module.network2.network_name
  remote_virtual_network_id = module.network0.network_id
}

