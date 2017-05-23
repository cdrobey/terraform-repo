variable "datacenter" {
    default = "Colorado"
}

variable "vmware_cluster" {
    default = "Virtual"
}

variable "vsphere_user" {
    default = "administrator@fr.lan"
}

variable "vsphere_password" {
    default = "Andy&C1ay"
}

variable "vsphere_server" {
    default = "vc.fr.lan"
}

provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"
  allow_unverified_ssl = "true"
}

# Deploy a virtual machine
resource "vsphere_virtual_machine" "centos00" {
  name = "lab-centos00"
  vcpu = 1
  memory = 1024
  datacenter = "${var.datacenter}"
  cluster = "${var.vmware_cluster}"
  domain = "fr.lan"

  network_interface {
      label = "VM Network"
  }

  disk {
    template = "Lab/CENTOS-TPL"
    datastore = "DS-LAB-NFS01"
    type = "thin"
  }
}
