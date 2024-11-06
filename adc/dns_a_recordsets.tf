
module "dnszone" {
  source              = "../modules/dnszone/"
  name                = var.rg_name
  resource_group_name = "azureuser"
}

resource "azurerm_dns_ns_record" "servers" {
  depends_on = [ module.dnszone ]

  name =  var.rg_name
  zone_name  = azurerm_dns_zone.papazone.name
  resource_group_name = "azureuser"
  ttl                = 300

  records  = module.dnszone.name_servers
}

resource "azurerm_dns_a_record" "controller" {
    name  = "controller"
    depends_on    =  [ module.dnszone ]

    zone_name =  module.dnszone.name
    resource_group_name  = "azureuser"
    ttl                  = 300
    records              = [ module.controller.ip_address ]
}

resource "azurerm_dns_a_record" "jumphost" {
    name  = "jumphost"
    depends_on    =  [ module.dnszone ]

    zone_name =  module.dnszone.name
    resource_group_name  = "azureuser"
    ttl                  = 300
    records              = [ module.jumphost.ip_address ]
}

   
   
