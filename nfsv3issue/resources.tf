
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
