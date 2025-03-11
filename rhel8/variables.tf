
variable "rg_name" {
  description = "Resource Group used by the project"
}

variable "location" {
  description = "Location of the project"
}

variable "prefix" {
  description = "Location of the project"
}

variable "cidr_bits" {
  description = "Number of bits dedicated to the subnet mask"
  type        = string
  default     = "8"
}

variable "payg" {
  type = list(object({
    pubip           = bool
    name            = string
    publisher       = string
    offer           = string
    sku             = string
    image_version   = string
    size            = string
    custom_data     = string
    encrypt         = bool
  }))
  default = [
    {
    pubip         = true,
    name          = "redhat8",
    publisher     = "redhat",
    offer         = "rhel",
    sku           = "88-gen2",
    image_version = "latest",
    size          = "Standard_E32bs_v5",
    custom_data   = "/home/esv/lab/createlab/cloud_data/no_change.yml",
    encrypt       = false
    }
  ]
}

variable "byos" {
  type = list(object({
    pubip           = bool
    name            = string
    publisher       = string
    offer           = string
    sku             = string
    image_version   = string
    size            = string
    custom_data    =  string
    encrypt         = bool
  }))
  default = [
  ]
}
