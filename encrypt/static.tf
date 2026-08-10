
#module "jumphost" {
#    source                   = "./modules/jumphost"
#    depends_on               = [module.mynetwork]
#    server_name              = "jumphost"
#    region                   = var.region
#    resource_group           = azurerm_resource_group.myrg.name
#    nic0_ip                  = cidrhost(module.mynetwork.subnets_cidrs[0], 5)
#    nic0_subnetid            = module.mynetwork.subnets_ids[0]
#    pubip                    = true
#    storage_account          = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
#    publisher                = "canonical"
#    offer                    = "0001-com-ubuntu-server-jammy"
#    sku                      = "22_04-lts-gen2"
#    image_version            = "latest"
#}


#output "jumphostip" {
#  value = "jumpserver IP ${module.jumphost.ip_address}"
#}


