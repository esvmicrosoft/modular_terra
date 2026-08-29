
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
    pubip                = optional(bool,false)
    name                 = string
    publisher            = string
    offer                = string
    sku                  = string
    image_version        = string
    size                 = string
    custom_data          = string
    encrypt              = optional(bool, false)
    network_acceleration = optional(bool, false)
    nics                 = optional(string,"1")
    nvme                 = optional(string, "SCSI")
  }))
  default = [
    {
    pubip                = true,
    name                 = "redhat8"
    publisher            = "redhat"
    offer                = "rhel"
    sku                  = "810-gen2"
    image_version        = "latest"
    size                 = "Standard_D2ds_v6"
    custom_data          = "cloud_data/nvmedisks.yml"
    network_acceleration = true
    nics                 = "1"
    nvme                 = "NVMe"
    },
    {
    pubip                = true
    name                 = "redhat9"
    publisher            = "redhat"
    offer                = "rhel"
    sku                  = "9-lvm-gen2"
    image_version        = "latest"
    size                 = "Standard_D2ds_v6"
    custom_data          = "cloud_data/nvmedisks.yml"
    network_acceleration = true
    nics                 = "1"
    nvme                 = "NVMe"
    },
    {
    pubip                = true
    name                 = "redhat10"
    publisher            = "redhat"
    offer                = "rhel"
    sku                  = "9-lvm-gen2"
    image_version        = "latest"
    size                 = "Standard_E2s_v6"
    custom_data          = "cloud_data/nvmedisks.yml"
    network_acceleration = true
    nics                 = "1"
    nvme                 = "NVMe"
    },
    {
    pubip                = true
    name                 = "redhat10ds"
    publisher            = "redhat"
    offer                = "rhel"
    sku                  = "9-lvm-gen2"
    image_version        = "latest"
    size                 = "Standard_D2ds_v6"
    custom_data          = "cloud_data/nvmedisks.yml"
    network_acceleration = true
    nics                 = "1"
    nvme                 = "NVMe"
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
    encrypt              = optional(bool, false)
    network_acceleration = optional(bool, false)
    nics                 = optional(string,"1")
    nvme                 = optional(string, "SCSI")
  }))
  default = [
  ]
}
