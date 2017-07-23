variable "l_pm_name" {
  description = "The fqdn of the puppet master"
  default = ""
}

variable "l_pm_location" {
  default = ""
}

variable "l_pm_fip" {
}

variable "l_pm_ip" {
}


variable "l_tenant_network" {
  type        = "string"
  description = "The network to be used."
  default     = "infrastructure_network"
}

variable "l_role" {
  description = "The name of the role for the service"
}

variable "l_name" {
  description = "The name of the role for the service"
}

variable "l_location" {
  description = "The name of the role for the service"
}

variable "openstack_keypair" {
  type        = "string"
  description = "The keypair to be used."
  default     = "slice_terraform"
}
