
module "static_network" {
  source          = "../modules/network"
  depends_on      = [ module.myrg ]
  name            = "static"
  location        = var.location
  resource_group  = var.rg_name
  cidr            = "10.0.0.0/16"
  cidr_bits       = var.cidr_bits
}

module "adlab_network" {
  source          = "../modules/network"
  depends_on      = [ module.myrg ]
  name            = "adlab"
  location        = var.location
  resource_group  = var.rg_name
  cidr            = "10.1.0.0/16"
  cidr_bits       = var.cidr_bits
}

resource "azurerm_network_security_group" "nsg" {
  name                  = "${var.rg_name}-vnet-NSG-CASG"
  depends_on      = [ module.myrg ]
  location              = var.location
  resource_group_name   = var.rg_name

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

resource "azurerm_public_ip" "natgw_publicip" {
  name                = "nat-gateway-publicIP"
  depends_on          = [ module.adlab_network, module.myrg ]
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "natgw" {
  name                    = "natgw"
  depends_on              = [ module.adlab_network, module.myrg ]
  location                = var.location
  resource_group_name     = var.rg_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_nat_gateway_public_ip_association" "natgw_ip" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.natgw_publicip.id
}

resource "azurerm_subnet_nat_gateway_association" "private_network_escape" {
  depends_on       = [ module.adlab_network, module.myrg ]
  subnet_id        = module.adlab_network.subnets_ids[0]
  nat_gateway_id   = azurerm_nat_gateway.natgw.id
}

resource "azurerm_subnet_network_security_group_association" "static_nsg_asocc" {
  depends_on = [ module.static_network, module.myrg ]
  count      = length(module.static_network.subnets_ids)

  subnet_id                 = module.static_network.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "adlab_nsg_asocc" {
  depends_on = [ module.adlab_network, module.myrg ]
  count      = length(module.adlab_network.subnets_ids)

  subnet_id                 = module.adlab_network.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_virtual_network_peering" "staticnnetpeer" {
  name = "staticnnetpeer"
  depends_on = [ module.adlab_network, module.static_network, module.myrg ]
  
  resource_group_name    = var.rg_name
  virtual_network_name   = module.static_network.network_name
  remote_virtual_network_id  = module.adlab_network.network_id
}

resource "azurerm_virtual_network_peering" "adlabnetpeer" {
  name = "adlabnetpeer"
  depends_on = [ module.adlab_network, module.static_network, module.myrg ]

  resource_group_name   = var.rg_name
  virtual_network_name   = module.adlab_network.network_name
  remote_virtual_network_id  = module.static_network.network_id
}

