

resource "azurerm_dns_zone" "dnszone" {
  name = "${var.name}.quixsanchez.stream"
  resource_group_name  = "azureuser"
}

output "name_servers" {
  value = azurerm_dns_zone.dnszone.name_servers
}

output "name" {
  value = azurerm_dns_zone.dnszone.name
}

