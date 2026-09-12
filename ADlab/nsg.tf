
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.rg_name}-vnet-NSG-CASG"
  depends_on          = [module.myrg]
  location            = var.location
  resource_group_name = var.rg_name

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

resource "azurerm_subnet_network_security_group_association" "network_ad2022_nsg_asocc" {
  depends_on = [module.network_ad2022, module.myrg]
  count      = length(module.network_ad2022.subnets_ids)

  subnet_id                 = module.network_ad2022.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "network_ad2025_nsg_asocc" {
  depends_on = [module.network_ad2025, module.myrg]
  count      = length(module.network_ad2025.subnets_ids)

  subnet_id                 = module.network_ad2025.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "network_nsg_asocc" {
  depends_on = [module.network, module.myrg]
  count      = length(module.network.subnets_ids)

  subnet_id                 = module.network.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

