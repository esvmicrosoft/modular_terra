
resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  address_space       = ["${var.cidr}"]
  location            = var.location
  resource_group_name = var.resource_group

  dynamic "subnet" {
    for_each = range(4)
    content {
      name  = "subnet${subnet.key}"
      address_prefixes  = [
              cidrsubnet(var.cidr,parseint(var.cidr_bits,10),subnet.key)
      ]
    }
  }

  tags = {
    environment = "Terraform Demo"
  }
}

output "network_name" {
  description = "Name of virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "network_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "subnets_cidrs" {
  description = "CIDR of the subnets"
  value       = azurerm_virtual_network.vnet.subnet[*].address_prefixes[0]
}

output "subnets_ids" {
  description = "ID of subnets Id"
  value       = azurerm_virtual_network.vnet.subnet[*].id
}

