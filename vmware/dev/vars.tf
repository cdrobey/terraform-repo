#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable "vsphere_user_name" {}
variable "vsphere_password"  {}
variable "vsphere_server"    {}
variable "vsphere_sshkey"    {}

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable datacenter      { default = "Lab-DC" }
variable cluster         { default = "Lab-Cluster" }
variable hosts           { default = [ "labvesx01.fr.lab", "labvesx02.fr.lab"] }
variable network0_switch { default = "vSwitch0" }
variable network0        { default = "EAN"}
variable datastore0      { default = "LAB-NFS01" }

#--------------------------------------------------------------
# Puppet Master Provisioning Variables
#--------------------------------------------------------------
variable puppet_master_name       { default = "puppet" }
variable puppet_master_domain     { default = "fr.lab" }
variable puppet_master_datacenter { default = "Lab-DC" }
variable puppet_master_network    { default = "EAN" }
variable puppet_master_datastore  { default = "LAB-NFS01" }
variable git_pri_key              { default = "~/.ssh/github" }
variable git_pub_key              { default = "~/.ssh/github.pub" }
variable git_url                  { default = "https://github.com/cdrobey/puppet-repo" }

#--------------------------------------------------------------
# LINUX Server Provisioning Variables
#--------------------------------------------------------------
variable linux_name     { default = "linux" }
variable linux_domain   { default = "fr.lab" }
variable linux_network  { default = "VM Network" }

#--------------------------------------------------------------
# Windows Server Provisioning Variables
#--------------------------------------------------------------
variable windows_name     { default = "windows" }
variable windows_domain   { default = "fr.lab" }
variable windows_network  { default = "VM Network" }
