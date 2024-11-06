
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
  source          = "../modules/stgacct/diag"
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
  cidr            = "10.0.0.0/22"
  cidr_bits       = var.cidr_bits
}

module "dnszone" {
  source = "../modules/dnszone"
  depends_on = [ module.machines ]
  rg_name = var.rg_name
}
