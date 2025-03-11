
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
    custom_data    =  string
    encrypt         = bool
  }))
  default = [
    {
    pubip         = true,
    name          = "alma8",
    publisher     = "almalinux",
    offer         = "almalinux-x86_64",
    sku           = "8-gen2",
    image_version = "latest",
    custom_data   = "/home/esv/lab/createlab/cloud_data/no_change.yml",
    encrypt       = false
    },
    {
    pubip         = true,
    name          = "alma9",
    publisher     = "almalinux",
    offer         = "almalinux-x86_64",
    sku           = "9-gen2",
    image_version = "latest",
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
    custom_data    =  string
    encrypt         = bool
  }))
  default = [
    {
    pubip         = true,
    name          = "rocky8",
    publisher     = "ciq",
    offer         = "rocky",
    sku           = "rocky-8-6-free",
    image_version = "latest",
    custom_data   = "/home/esv/lab/createlab/cloud_data/no_change.yml",
    encrypt       = false
    },
    {
    pubip         = true,
    name          = "rocky9",
    publisher     = "ciq",
    offer         = "rocky",
    sku           = "rocky-9-0-free",
    image_version = "latest",
    custom_data   = "/home/esv/lab/createlab/cloud_data/no_change.yml",
    encrypt       = false
    }
  ]
}
