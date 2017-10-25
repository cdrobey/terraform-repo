#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable "vsphere_user_name" {}
variable "vsphere_password"  {}
variable "vsphere_server"    {}
variable "vsphere_sshkey"    {}
variable "windows_user_name" {}
variable "windows_password"  {}

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable datacenter      { default = "Datacenter" }
variable cluster         { default = "Lab-Cluster" }
variable hosts           { default = [ "labvesx01.fr.lan", "labvesx02.fr.lan"] }
variable network0_switch { default = "vSwitch0" }
variable network0        { default = "VM Network"}
variable datastore0      { default = "vdsnfs01" }
variable dns_servers     { default = [ "10.1.3.1", "10.1.1.1"] }
variable dns_suffixes    { default = [ "fr.lan"] }
variable time_zone       { default = "MST7MDT" }     

#--------------------------------------------------------------
# Puppet Master Provisioning Variables
#--------------------------------------------------------------
variable puppet_master_name       { default = "labpuppet" }
variable puppet_master_domain     { default = "fr.lan" }
variable puppet_master_datacenter { default = "Datacenter" }
variable puppet_master_network    { default = "VM Network" }
variable puppet_master_datastore  { default = "vdsnfs01" }
variable git_pri_key              { default = "~/.ssh/github" }
variable git_pub_key              { default = "~/.ssh/github.pub" }
variable git_url                  { default = "https://github.com/cdrobey/puppet-repo" }

#--------------------------------------------------------------
# Jenkins Server Provisioning Variables
#--------------------------------------------------------------
variable jenkins_name     { default = "labjenkins" }
variable jenkins_domain   { default = "fr.lan" }
variable jenkins_network  { default = "VM Network" }

#--------------------------------------------------------------
# LINUX Server Provisioning Variables
#--------------------------------------------------------------
variable linux_name     { default = "lablinux" }
variable linux_domain   { default = "fr.lan" }
variable linux_network  { default = "VM Network" }

#--------------------------------------------------------------
# Windows Server Provisioning Variables
#--------------------------------------------------------------
variable windows_name    { default = "labwindows" }
variable windows_domain  { default = "fr.lan" }
variable windows_network { default = "VM Network" }
