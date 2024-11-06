

variable "server_name" {
  description = "defines the name of the machine to use"
  type        = string
}

variable "location" {
  description = "location of the resource"
  type        = string
}

variable "resource_group" {
  description = "defines the RG of the machine to use"
  type        = string
}


variable "nic0_ip" {
  description = "NIC IP address"
  type        = string
}


variable "nic0_subnetid" {
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

variable "userpassword" {
  description = "Windows Admin Password"
  default     = false
}

variable "adsetup" {
  description = "Whether setup an ADC controller or nah!"
  default     = false
}
