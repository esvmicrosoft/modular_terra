
module "dnszone" {

  source = "../modules/dnszone"
  depends_on  = [ module.machines ]

  rg_name  = var.rg_name
}
