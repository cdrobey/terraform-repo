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