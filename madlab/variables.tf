
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
  }))
  default = [
    {
      pubip                = false,
      name                 = "alma10",
      publisher            = "almalinux",
      offer                = "almalinux-x86_64",
      sku                  = "10-gen2",
      image_version        = "latest",
      size                 = "Standard_D2s_v4",
      custom_data          = "custom_data/alma10.yml",
      encrypt              = false,
      network_acceleration = true
    },
    {
      pubip                = false
      name                 = "rhel9"
      publisher            = "redhat"
      offer                = "rhel"
      sku                  = "9-lvm-gen2"
      image_version        = "latest"
      size                 = "Standard_D2s_v4",
      custom_data          = "custom_data/rhel.yml",
      encrypt              = false,
      network_acceleration = true
    },
    {
      pubip = false
      name = "rhel10"
      publisher = "redhat"
      offer     = "rhel"
      sku       = "10-lvm-gen2"
      image_version = "latest"
      size                 = "Standard_D2s_v4",
      custom_data          = "custom_data/rhel10.yml",
      encrypt              = false,
      network_acceleration = true
    },
    {
      pubip = false
      name = "rhel8"
      publisher = "redhat"
      offer     = "rhel"
      sku       = "8-lvm-gen2"
      image_version = "latest"
      size                 = "Standard_D2s_v4",
      custom_data          = "custom_data/rhel.yml",
      encrypt              = false,
      network_acceleration = true
    },
    {
      pubip = false
      name = "ubuntu2404"
      publisher = "canonical"
      offer     = "ubuntu-24_04-lts"
      sku       = "server"
      image_version = "latest"
      size                 = "Standard_D2s_v4",
      custom_data          = "custom_data/ubuntu.yml",
      encrypt              = false,
      network_acceleration = true
    },
    {
      pubip = false
      name = "sles15"
      publisher = "suse"
      offer     = "sles-sap-15-sp6"
      sku       = "gen2"
      image_version = "latest"
      size                 = "Standard_D2s_v4",
      custom_data          = "custom_data/rhel.yml",
      encrypt              = false,
      network_acceleration = true
    },
    {
      pubip = false
      name = "ubuntu2204"
      publisher = "canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      image_version = "latest"
      size                 = "Standard_D2s_v4",
      custom_data          = "custom_data/ubuntu.yml",
      encrypt              = false,
      network_acceleration = true
    },
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
  ]
}
