
# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.rg_name
  }
  byte_length = 8
}

module "myrg" {
  source   = "../modules/rg"
  name     = var.rg_name
  location = var.location
}

resource "azurerm_dns_zone" "papazone" {
  resource_group_name = "azureuser"
  name  = "quixsanchez.stream"

  lifecycle {
    prevent_destroy = true
  }
}

module "stgacct" {
  source          = "../modules/stgacct/diag"
  depends_on      = [ module.myrg ]
  name            = "${var.prefix}diag${random_id.randomId.hex}"
  resource_group  = var.rg_name
  location        = var.location
}

module "windows_network" {
  source          = "../modules/network"
  depends_on      = [ module.myrg ]
  name            = "${var.rg_name}-windows-vnet"
  location        = var.location
  resource_group  = var.rg_name
  cidr            = "10.0.1.0/24"
  cidr_bits       = var.cidr_bits
}

module "linux_network" {
  source          = "../modules/network"
  depends_on      = [ 
                      module.myrg,
                      module.windows_network
                    ]
  name            = "${var.rg_name}-linux-vnet"
  location        = var.location
  resource_group  = var.rg_name
  cidr            = "10.0.2.0/24"
  cidr_bits       = var.cidr_bits
}

resource "azurerm_virtual_network_peering" "windowsnetpeer" {
  name = "windowsnetpeer"
  resource_group_name = var.rg_name
  virtual_network_name   = module.windows_network.network_name
  remote_virtual_network_id  = module.linux_network.network_id
}

resource "azurerm_virtual_network_peering" "linuxnetpeer" {
  name = "linuxnetpeer"
  resource_group_name = var.rg_name
  virtual_network_name   = module.linux_network.network_name
  remote_virtual_network_id  = module.windows_network.network_id
}

