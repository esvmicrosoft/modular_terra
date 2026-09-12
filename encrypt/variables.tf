
variable "rg_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
}

variable "prefix" {
  description = "A three character string for personal localization"
}

variable "cidr_bits" {
  description = "Number of bits dedicated to subnetting"
  type        = string
  default     = "8"
}

variable "payg" {
  type = list(object({
    pubip                = optional(bool, false)
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
      pubip         = true
      name          = "rhel8g2"
      publisher     = "redhat"
      offer         = "rhel"
      sku           = "810-gen2"
      image_version = "latest"
      size          = "Standard_D2s_v4",
      custom_data   = "cloud_data/rhel8.yml"
      encrypt       = true
    },
    {
      name          = "ubu2004g2"
      pubip         = true
      publisher     = "canonical"
      offer         = "0001-com-ubuntu-server-focal"
      sku           = "20_04-lts-gen2"
      image_version = "latest"
      size          = "Standard_D2s_v4",
      custom_data   = "cloud_data/ubuntu.yml"
      encrypt       = true
    }
  ]
}

#### variable "data" {
####   type = list(object({
####     pubip                = optional(bool, false)
####     name                 = string
####     publisher            = string
####     offer                = string
####     sku                  = string
####     image_version        = string
####     size                 = string
####     custom_data          = string
####     encrypt              = optional(bool, false)
####     network_acceleration = optional(bool, false)
####     nics                 = optional(string,"1")
####     nvme                 = optional(string, "SCSI")
####   }))
####   default = [
####   ]
#### }

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
