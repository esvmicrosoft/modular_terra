module "network" {
  source          = "../modules/network"
  depends_on      = [ module.myrg ]
  name            = "${var.rg_name}-vnet"
  location        = var.location
  resource_group  = var.rg_name
  cidr            = "10.0.0.0/16"
  cidr_bits       = var.cidr_bits
}

resource "azurerm_network_security_group" "nsg" {
  name                  = "${var.rg_name}-vnet-SG-CASG"
  depends_on            = [ module.myrg ]
  location              = var.location
  resource_group_name   = var.rg_name

  security_rule {
    name                       = "azcloud"
    priority                   = 2000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "AzureCloud"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_ranges    = ["22","3389"]
  }
  security_rule {
    name                       = "vnetaccess"
    priority                   = 3000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
  }
}


resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  depends_on = [ module.network, module.myrg ]
  count      = length(module.network.subnets_ids)

  subnet_id                 = module.network.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}
