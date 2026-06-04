
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
    network_acceleration = bool
    nics            = string
  }))
  default = [
    {
    pubip         = true,
    name          = "nfs3server",
    publisher     = "almalinux",
    offer         = "almalinux-x86_64",
    sku           = "9-gen2",
    image_version = "latest",
    size          = "Standard_D2s_v3",
    custom_data   = "custom_data/nfsserver.yml",
    encrypt       = false,
    network_acceleration = true,
    nics = 1
    },
    {
    pubip         = true,
    name          = "rhel9client",
    publisher     = "redhat",
    offer         = "rhel",
    sku           = "9-lvm-gen2",
    image_version = "latest",
    size          = "Standard_D2s_v3",
    custom_data   = "custom_data/nfsclient.yml",
    encrypt       = false,
    network_acceleration = true,
    nics = 1
    },
    {
    pubip         = true,
    name          = "rhel8client",
    publisher     = "redhat",
    offer         = "rhel",
    sku           = "86-gen2",
    image_version = "latest",
    size          = "Standard_D2s_v3",
    custom_data   = "custom_data/nfsclient.yml",
    encrypt       = false,
    network_acceleration = true,
    nics = 1
    },
    {
    pubip         = true,
    name          = "marinerclient",
    publisher     = "MicrosoftCBLMariner",
    offer         = "azure-linux-3",
    sku           = "azure-linux-3-gen2",
    image_version = "latest",
    size          = "Standard_D2s_v3",
    custom_data   = "custom_data/nochange.yml",
    encrypt       = false,
    network_acceleration = true,
    nics = 1
    },
    {
    pubip         = true,
    name          = "marinerclientii",
    publisher     = "MicrosoftCBLMariner",
    offer         = "azure-linux-3",
    sku           = "azure-linux-3-gen2",
    image_version = "latest",
    size          = "Standard_B4s_v2",
    custom_data   = "custom_data/nochange.yml",
    encrypt       = false,
    network_acceleration = true,
    nics = 1
    }
#    {
#    pubip         = true,
#    name          = "alma9client",
#    publisher     = "almalinux",
#    offer         = "almalinux-x86_64",
#    sku           = "9-gen2",
#    image_version = "latest",
#    size          = "Standard_D2s_v3",
#    custom_data   = "custom_data/nfsclient.yml",
#    encrypt       = false,
#    network_acceleration = true
#    },
#    {
#    pubip         = true,
#    name          = "alma8client",
#    publisher     = "almalinux",
#    offer         = "almalinux-x86_64",
#    sku           = "8-gen2",
#    image_version = "latest",
#    size          = "Standard_D2s_v3",
#    custom_data   = "custom_data/nfsclient.yml",
#    encrypt       = false,
#    network_acceleration = true
#    }
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
    network_acceleration = bool
  }))
  default = [
#    {
#    pubip         = true,
#    name          = "rocky8i",
#    publisher     = "resf",
#    offer         = "rockylinux-x86_64",
#    sku           = "8-lvm",
#    image_version = "latest",
#    size          = "Standard_D2s_v5",
#    custom_data   = "/home/esv/lab/createlab/cloud_data/no_change.yml",
#    encrypt       = false,
#    network_acceleration = true
#    },
#    {
#    pubip         = true,
#    name          = "rocky9i",
#    publisher     = "resf",
#    offer         = "rockylinux-x86_64",
#    sku           = "9-lvm",
#    image_version = "latest",
#    size          = "Standard_D2s_v5",
#    custom_data   = "/home/esv/lab/createlab/cloud_data/no_change.yml",
#    encrypt       = false,
#    network_acceleration = true
#    }
  ]
}
