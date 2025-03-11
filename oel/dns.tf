
module "dnszone" {

  source          = "../modules/dnszone"
  depends_on      = [ module.machines ]
  resource_group  = var.rg_name
  name            = var.rg_name
}
