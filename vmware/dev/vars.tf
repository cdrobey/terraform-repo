#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable "vsphere_user_name"    {}
variable "vsphere_tenant_name"  {}
variable "vsphere_password"     {}
variable "vsphere_auth_url"     {}
variable "vsphere_keypair"      {}

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable datacenter { default = "demo.os" }
variable cluster    { default = "demo_cluster" }
variable hosts      { default = [ "lab-vesx01", "lab-vesx02" ] }
variable network0   { default = "demo.os" }
variable datastore0 { default = "demo-nfs" }

#--------------------------------------------------------------
# Puppet Master Provisioning Variables
#--------------------------------------------------------------
variable puppet_master_name     { default = "puppet" }
variable puppet_master_domain   { default = "demo.os" }
variable puppet_master_network  { default = "demo_network" }
variable git_pri_key            { default = "~/.ssh/github" }
variable git_pub_key            { default = "~/.ssh/github.pub" }
variable git_url                { default = "https://github.com/cdrobey/puppet-repo" }

#--------------------------------------------------------------
# LINUX Server Provisioning Variables
#--------------------------------------------------------------
variable linux_name     { default = "linux" }
variable linux_domain   { default = "demo.os" }
variable linux_network  { default = "demo_network" }

#--------------------------------------------------------------
# Windows Server Provisioning Variables
#--------------------------------------------------------------
variable windows_name     { default = "windows" }
variable windows_domain   { default = "demo.os" }
variable windows_network  { default = "demo_network" }
