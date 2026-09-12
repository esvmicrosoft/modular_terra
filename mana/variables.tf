
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
      name                 = "alma9i",
      publisher            = "almalinux",
      offer                = "almalinux-x86_64",
      sku                  = "9-gen2",
      image_version        = "latest",
      size                 = "Standard_D2s_v5",
      custom_data          = "/home/esv/lab/createlab/cloud_data/no_change.yml",
      encrypt              = false,
      network_acceleration = true
    },
    {
      pubip                = true,
      name                 = "rhel9i",
      publisher            = "redhat",
      offer                = "rhel-raw",
      sku                  = "9-raw",
      image_version        = "latest",
      size                 = "Standard_D2s_v5",
      custom_data          = "/home/esv/lab/createlab/cloud_data/no_change.yml",
      encrypt              = false,
      network_acceleration = true
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
    encrypt              = bool
    network_acceleration = bool
  }))
  default = [
    {
      pubip                = true,
      name                 = "rocky8i",
      publisher            = "resf",
      offer                = "rockylinux-x86_64",
      sku                  = "8-lvm",
      image_version        = "latest",
      size                 = "Standard_D2s_v5",
      custom_data          = "/home/esv/lab/createlab/cloud_data/no_change.yml",
      encrypt              = false,
      network_acceleration = true
    },
    {
      pubip                = true,
      name                 = "rocky9i",
      publisher            = "resf",
      offer                = "rockylinux-x86_64",
      sku                  = "9-lvm",
      image_version        = "latest",
      size                 = "Standard_D2s_v5",
      custom_data          = "/home/esv/lab/createlab/cloud_data/no_change.yml",
      encrypt              = false,
      network_acceleration = true
    }
  ]
}
