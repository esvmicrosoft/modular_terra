
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


module "stgacct" {
  source          = "../modules/stgacct/nfsv3"
  depends_on      = [ module.myrg ]
  name            = "${var.prefix}diag${random_id.randomId.hex}"
  resource_group  = var.rg_name
  location        = var.location
}

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
  name                  = "${var.rg_name}-vnet-NSG-CASG"
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


resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  depends_on = [ module.network, module.myrg ]
  count      = length(module.network.subnets_ids)

  subnet_id                 = module.network.subnets_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}
