
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
  default     = "0"
}

variable "userpassword" {
  description = "Password for  the windows admin user"
  type = string
}

variable "payg" {
  type = list(object({
    pubip           = bool
    name            = string
    publisher       = string
    offer           = string
    sku             = string
    image_version   = string
    custom_data    =  string
    encrypt         = bool
  }))
  default = [
    {
    pubip         = true,
    name          = "rhel8",
    publisher     = "redhat",
    offer         = "rhel",
    sku           = "88-gen2",
    image_version = "latest"
    custom_data   = "rhel8.yml",
    encrypt       = false
    },
    {
    pubip         = false,
    name          = "rhel8",
    publisher     = "redhat",
    offer         = "rhel",
    sku           = "88-gen2",
    image_version = "latest"
    custom_data   = "teams.yml",
    encrypt       = false
    },
    {
    pubip         = true,
    name          = "mariner3",
    publisher     = "microsoftcblmariner",
    offer         = "azure-linux-3",
    sku           = "azure-linux-3-gen2",
    image_version = "latest"
    custom_data   = "mariner3.yml",
    encrypt       = false
    },
    {
    pubip         = true,
    name          = "rhel8",
    publisher     = "redhat",
    offer         = "rhel",
    sku           = "88-gen2",
    image_version = "latest"
    custom_data   = "rhel8.yml",
    encrypt       = false
    }
  ]
}
