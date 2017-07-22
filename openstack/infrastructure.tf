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
