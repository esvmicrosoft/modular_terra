
variable "provided" {
  description = "last modified timestamp" 
  type = number
}

variable "required" {
  description = "last modified timestamp" 
  default = 20260601
  type = number
}

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

variable "priv_index" {
  description = "List of cidrs for the network"
  type       = number
}

variable "cidr_list" {
  description = "List of cidrs for the network"
  type       = list
}

variable "nic_subnetid" {
  description = "NICs subnet ID"
  type        = list
}

variable "pubip" {
  description = "Assign public ip or not"
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

variable "size" {
  description = "Machine size to use in deployment"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "custom_data" {
  description = "custom datafile to use"
  default = "Cg=="
}

variable "dns_server" {
  description = "custom DNS IP address"
  default = null
  type = list
}

variable "network_acceleration" {
  description = "Assign public ip or not"
  default     = false
}

variable "encrypt" {
  description = "whether to encrypt the machine or not"
  default     = false
}

variable "keyvaultid" {
  description = "Azure keyvault id for disk encryption"
  type  = string
  default = null
}

variable "keyvaulturi" {
  description = "Azure keyvault URI for disk encryption"
  type  = string
  default = null
}

variable "diskencryptkey" {
  description = "key used for disk encryption"
  type  = string
  default  = null
}

variable "storage_account" {
  description = "Storage Account used for boot diagnostics"
  type        = string
  default     = null
}

variable "avsetid" {
  description = "Availability set used for VM"
  default     = null
}

variable "nics" {
  description = "Number of network interface cards (must be the same or lower than the number of subnets)"
  type        = string
  default     = "1"
}

variable disk_controller_type {
  description = "NVMe or SCSI disk type"
  type        = string
  default     = "SCSI"
}

