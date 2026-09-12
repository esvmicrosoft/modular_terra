
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

variable "userpassword" {
  description = "Window's admin password"
  type        = string
}

variable "payg" {
  type = list(object({
    pubip                = bool
    name                 = string
    publisher            = string
    offer                = string
    sku                  = string
    image_version        = string
    size                 = string
    custom_data          = string
    encrypt              = optional(bool, false)
    network_acceleration = optional(bool, false)
    nics                 = optional(string, "1")
    nvme                 = optional(string, "SCSI")
  }))
  default = [
    {
      pubip                = true,
      name                 = "sles12",
      publisher            = "suse",
      offer                = "sles-sap-12-sp5",
      sku                  = "gen2",
      image_version        = "latest",
      size                 = "Standard_D2s_v4",
      custom_data          = "custom_data/sles12.yml",
    }
  ]
}

variable "byos" {
  type = list(object({
    pubip                = bool
    name                 = string
    publisher            = string
    offer                = string
    sku                  = string
    image_version        = string
    size                 = string
    custom_data          = string
    encrypt              = optional(bool, false)
    network_acceleration = optional(bool, false)
    nics                 = optional(string, "1")
    nvme                 = optional(string, "SCSI")
  }))
  default = [
  ]
}

