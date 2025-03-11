

variable "name" {
  description = "defines the name of the machine to use"
  type        = string
}

variable "resource_group" {
  description = "defines the RG of the machine to use"
  type        = string
}

variable "location" {
  description = "location of the resource"
  type        = string
}

variable "priv_ip" {
  description = "NIC IP address"
  type        = string
}

variable "nic_subnetid" {
  description = "NICs subnet ID"
  type        = string
}

variable "pubip" {
  description = "Assign public ip or not"
  default     = false
}

variable "storage_account" {
  description = "Diagnostics Storage Account"
  default     = false
}

variable "publisher" { 
  description = "Image Publisher"
}

variable "offer" { 
  description = "machine's offer"
}

variable "sku" { 
  description = "SKU Publisher"
}

variable "image_version" { 
  description = "Image Version"
}

variable "custom_data" {
  description = "custom datafile to use"
  default = "/dev/null"
}

variable "dns_server" {
  description = "custom DNS IP address"
  default = null
  type = list
}

# variable "keyvaultid" {
#   description = "Azure keyvault id for disk encryption"
#   type  = string
# }

# variable "keyvaulturi" {
#   description = "Azure keyvault URI for disk encryption"
#   type  = string
# }

# variable "diskencryptkey" {
#   description = "key used for disk encryption"
#   type  = string
# }

variable "encrypt" {
  description = "whether to encrypt the machine or not"
  default     = false
}

variable "avsetid" {
  description = "Availability set used for VM"
  default     = null
}
