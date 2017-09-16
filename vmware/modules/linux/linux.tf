#--------------------------------------------------------------
# This module creates the linux server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Linux Variables
#--------------------------------------------------------------
variable "linux_name"         {}
variable "linux_domain"       {}
variable "linux_dc"           {}
variable "linux_cluster"      {}
variable "linux_domain"       {}
variable "linux_ds"           {}
variable "master_name"        {}
variable "master_domain"      {}
variable "master_ip"          {}
variable "openstack_keypair"  {}
variable "tenant_network"     {}

#--------------------------------------------------------------
# Resources: Build Linux Configuration
#--------------------------------------------------------------

data "template_file" "linux" {
    template = "${file("../bootstrap/bootstrap_pa.tpl")}"
    vars {
        linux_name  = "${var.linux_name}"
        linux_fqdn  = "${var.linux_name}.${var.linux_domain}"
        linux_ip    = "${openstack_compute_floatingip_v2.linux.address}"
        master_name = "${var.master_name}"
        master_fqdn = "${var.master_name}.${var.master_domain}"
        master_ip   = "${var.master_ip}"
    }
}

resource "vsphere_virtual_machine" "centos" {
  domain = "${var.linux_domain}"
  datacenter = "${var.linux_dc}"
  cluster = "${var.linux_cluster}"
  name   = "${var.linux_name}.${var.linux_domain}"

  vcpu   = 1
  memory = 1024

  network_interface {
    label = "${var.tenant_network}"
  }

  disk {
    template = "centos_7_x86_64"
    type = "thin"
    datastore = "${var.linux_ds}"
  }
  user_data = "${data.template_file.linux.rendered}"
}
