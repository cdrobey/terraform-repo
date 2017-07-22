variable "puppet_master_name" {
  description = "The fqdn of the puppet master"
  default = "puppet.infrastructure.lab"
}

variable "puppet_master_ip" {
  description = "The IP address of the puppet master"
  default = "192.168.1.10"
}


module "base_network" {
  source = "./networking"
}

module "linuxnode01" {
  source = "./linux_node"

  name = "linuxnode01"
  role = "generic_website"
  location = "chicago"
  tenant_network = "chicago_network"
  puppet_master_name = "${var.puppet_master_name}"
  puppet_master_ip = "${var.puppet_master_ip}"
}
