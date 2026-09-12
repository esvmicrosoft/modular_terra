
## Create Datadisk
module "datadisks" {
  count = length(var.payg) * 2

  depends_on     = [module.myrg]
  source         = "../modules/disks/datadisk"
  disk_name      = "datadisk${count.index}"
  location       = var.location
  resource_group = var.rg_name
  disk_size      = "10"
}

## Attach Datadisk to the instances
resource "azurerm_virtual_machine_data_disk_attachment" "association0" {
  count = length(var.payg)

  depends_on = [module.datadisks,
    module.payg
  ]
  managed_disk_id    = module.datadisks[count.index * 2].disk_id
  virtual_machine_id = module.payg[count.index].machine.id
  lun                = 0
  caching            = "None"
}

## Attach Datadisk to the instances
resource "azurerm_virtual_machine_data_disk_attachment" "association1" {
  count = length(var.payg)

  depends_on = [module.datadisks,
    module.payg
  ]
  managed_disk_id    = module.datadisks[count.index * 2 + 1].disk_id
  virtual_machine_id = module.payg[count.index].machine.id
  lun                = 1
  caching            = "None"
}
