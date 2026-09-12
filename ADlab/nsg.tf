
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

resource "azurerm_subnet_network_security_group_association" "network0_nsg_asocc" {
  depends_on = [module.network0, module.myrg]
  count      = length(module.network0.subnets_ids)

  subnet_id                 = module.network0.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "network1_nsg_asocc" {
  depends_on = [module.network1, module.myrg]
  count      = length(module.network1.subnets_ids)

  subnet_id                 = module.network1.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "network2_nsg_asocc" {
  depends_on = [module.network2, module.myrg]
  count      = length(module.network2.subnets_ids)

  subnet_id                 = module.network2.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

