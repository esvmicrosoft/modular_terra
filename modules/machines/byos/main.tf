
resource "azurerm_public_ip" "public_ip_address" {
    count    =  var.pubip ? 1 : 0
    name   = "${var.name}-public-ip"
    location = var.location
    resource_group_name = var.resource_group
    allocation_method   = "Static"
    sku                 = "Standard"
    ip_version          = "IPv4"
}

resource "azurerm_network_interface" "nic0" {
  name                    = "${var.name}-eth0" 
  location                = var.location
  resource_group_name     = var.resource_group
  dns_servers             =  var.dns_server 


  ip_configuration {
    name                           = "${var.name}-eth0_priv"
    subnet_id                      = var.nic_subnetid
    private_ip_address_allocation  = "Static"
    private_ip_address             = var.priv_ip
    primary                        = "true"
    public_ip_address_id           = var.pubip ? azurerm_public_ip.public_ip_address[0].id : null
  }
}

data "template_cloudinit_config" "config" {
  gzip = true
  base64_encode  =  true

  part { 
    content_type = "text/cloud-config"
    content   = file("${var.custom_data}") 
  }
}

resource "azurerm_linux_virtual_machine" "machine" {
    name                   = var.name
    location               = var.location
    resource_group_name    = var.resource_group
    network_interface_ids  = [azurerm_network_interface.nic0.id]
    size                   = "Standard_D2s_v3"

    computer_name          = var.name
    admin_username         = "azureuser"
    custom_data            = data.template_cloudinit_config.config.rendered 

    availability_set_id    = var.avsetid 

    plan {
      publisher =  var.publisher
      product   =  var.offer
      name      =  var.sku
    }

    source_image_reference {
      publisher   = var.publisher
      offer       = var.offer
      sku         = var.sku
      version     = var.image_version
    }

    os_disk {
      caching              = "None"
      storage_account_type = "StandardSSD_LRS"
      disk_size_gb = var.publisher == "microsoftcblmariner" ? 30 : null
    }

    admin_ssh_key {
      username    = "azureuser"
      public_key  = file("~/.ssh/azureuser_key.pub")
    }

    boot_diagnostics {
        storage_account_uri = var.storage_account
    }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "schedule" {
    virtual_machine_id = azurerm_linux_virtual_machine.machine.id
    location           = azurerm_linux_virtual_machine.machine.location
    enabled            = true 

    daily_recurrence_time = "0100"
    timezone              = "UTC"

    notification_settings {
        enabled     = false
    }
}


output "ip_address" {
  value = var.pubip ? azurerm_public_ip.public_ip_address[0].ip_address : null
}

######resource "azurerm_virtual_machine_extension" "bootstrap" {
######
######  name                 = "bootstrap_extension"
######  virtual_machine_id   = azurerm_linux_virtual_machine.machine.id
######  publisher            = "Microsoft.Azure.Extensions"
######  type                 = "CustomScript"
######  type_handler_version = "2.0"
######
######  settings = <<SETTINGS
######    {
######      "commandToExecute":   "while [ ! -f /data/extension_is_done ]; do sleep 30; done; touch /data/extensions_checked"
######    }
######  SETTINGS
######
######  depends_on   = [ azurerm_virtual_machine_data_disk_attachment.datadisk_attachment ]
######}
######
###### resource "azurerm_virtual_machine_extension" "linux_ade" {
###### 
######    count    =  var.encrypt ? 1 : 0
######
######    #name    = "Microsoft.Azure.Security.AzureDiskEncryptionForLinux"
######    name    = "AzureDiskEncryptionForLinux"
######    virtual_machine_id  = azurerm_linux_virtual_machine.machine.id
######    publisher           = "Microsoft.Azure.Security"
######    type                = "AzureDiskEncryptionForLinux"
######    type_handler_version = "1.1"
######    auto_upgrade_minor_version = true
######
######    settings = <<SETTINGS
######    {
######        "EncryptionOperation"   : "EnableEncryption",
######        "KeyVaultURL"           : "${var.keyvaulturi}",
######        "KeyVaultResourceId"    : "${var.keyvaultid}",
######        "KeyEncryptionKeyURL"   : "${var.diskencryptkey}",
######        "KekVaultResourceId"    : "${var.keyvaultid}",
######        "KeyEncryptionAlgorithm" : "RSA-OAEP",
######        "VolumeType"             : "DATA"
######    }
######    SETTINGS
######
######    depends_on   = [
######                    azurerm_linux_virtual_machine.machine,
######                    azurerm_virtual_machine_data_disk_attachment.datadisk_attachment,
######                    azurerm_virtual_machine_extension.bootstrap
######                   ]
######}
