
resource "azurerm_network_security_group"  "nsg" {
  name                          = "${var.name}-vnet-NSG-CASG"
  location                      = var.location
  resource_group_name           = var.resource_group


  security_rule {
    name                        = "AzureCloud"
    priority                    = 2800
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_address_prefix       = "AzureCloud"
    source_port_range           = "*"
    destination_address_prefix  = "*"
    destination_port_range      = "22"
  }

  tags = {
    environment = "Terraform single network"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  address_space       = ["${var.cidr}"]
  location            = var.location
  resource_group_name = var.resource_group

  tags = {
    environment = "Terraform Demo"
  }
}

resource "azurerm_subnet" "subnets" {
  count = pow(2, parseint(var.cidr_bits,10))

  name                  = "subnet${count.index}"
  resource_group_name   = var.resource_group
  virtual_network_name  = azurerm_virtual_network.vnet.name
  address_prefixes      = [
              cidrsubnet(var.cidr,parseint(var.cidr_bits,10),count.index)
    ]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  count = pow(2, parseint(var.cidr_bits,10))

  subnet_id                 =  azurerm_subnet.subnets[count.index].id
  network_security_group_id =  azurerm_network_security_group.nsg.id
}


output "network_name" {
  description = "Name of virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "network_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "subnets_names" {
  description  = "Name of the virtual subnets"
  value        = azurerm_subnet.subnets[*].name
}

output "subnets_cidrs" {
  description = "CIDR of the subnets"
  value       = azurerm_subnet.subnets[*].address_prefixes[0]
}

output "subnets_ids" {
  description = "ID of subnets Id"
  value       = azurerm_subnet.subnets[*].id
}

