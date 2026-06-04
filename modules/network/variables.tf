
variable "name" {
  description = "defines the name of the vnet to use in the project"
  type        = string
}

variable "location" {
  description = "Location of the resource"
  type        = string
}

variable "resource_group" {
  description = "Name of the resource group containing the element"
  type        = string
}

variable "cidr" {
  description = "Network CIDR, without prefix"
  type        = string
}

variable "cidr_bits" {
  description = "Number of subnet bits to use"
  type        = string
}

variable "subnets" {
  description = "How many subnets to make"
  default = 4
  type        = string
}

variable "outbound_access" { 
  description = "Does the subnet allow outbound access by default"
  default     = false
  type        = bool
}
