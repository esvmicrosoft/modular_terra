
module "static_network" {
  source         = "../modules/network"
  depends_on     = [module.myrg]
  name           = "static"
  location       = var.location
  resource_group = var.rg_name
  cidr           = "10.0.0.0/16"
  cidr_bits      = var.cidr_bits
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.rg_name}-vnet-NSG-CASG"
  depends_on          = [module.myrg]
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "vnetaccess"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "VirtualNetwork"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "static_nsg_asocc" {
  count = length(module.static_network.subnets_ids)

  depends_on                = [module.static_network, module.myrg]
  subnet_id                 = module.static_network.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}
