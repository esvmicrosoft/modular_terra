
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
  default     = "2"
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
    custom_data   = "/dev/null",
    encrypt       = false
    }
  ]
}
