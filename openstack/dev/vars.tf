#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable "openstack_user_name" {}

variable "openstack_tenant_name" {}
variable "openstack_password" {}
variable "openstack_auth_url" {}
variable "openstack_keypair" {}

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable router {
  default = "router0"
}

variable network0 {
  default = "demo.os"
}

variable subnet0 {
  default = "demo_network"
}

variable network0_cidr {
  default = "192.168.1.0/24"
}

#--------------------------------------------------------------
# Puppet Master Provisioning Variables
#--------------------------------------------------------------
variable puppet_master_name {
  default = "puppet"
}

variable puppet_master_domain {
  default = "demo.os"
}

variable puppet_master_network {
  default = "demo_network"
}

variable git_pri_key {
  default = "~/.ssh/github"
}

variable git_pub_key {
  default = "~/.ssh/github.pub"
}

variable git_url {
  default = "https://github.com/cdrobey/puppet-repo"
}

#--------------------------------------------------------------
# LINUX Server Provisioning Variables
#--------------------------------------------------------------
variable linux_name {
  default = "linux"
}

variable linux_domain {
  default = "demo.os"
}

variable linux_network {
  default = "demo_network"
}
