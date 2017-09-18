#--------------------------------------------------------------
# This module creates the linux server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Linux Variables
#--------------------------------------------------------------
variable "name"       {}
variable "domain"     {}
variable "datacenter" {}
variable "datastore"  {}
variable "network"    {}
variable "master_name"      {}
variable "master_domain"    {}

#--------------------------------------------------------------
# Resources: Build Linux Configuration
#--------------------------------------------------------------
data "template_file" "init" {
    template = "${file("../bootstrap/bootstrap_pa.tpl")}"
    vars {
        name        = "${var.name}"
        fqdn        = "${var.name}.${var.domain}"
        master_name = "${var.master_name}"
        master_fqdn = "${var.master_name}.${var.master_domain}"
    }
}

resource "vsphere_virtual_machine" "centos" {
  datacenter    = "${var.datacenter}"
  name          = "${var.name}.${var.domain}"
  vcpu          = 1
  memory        = 1024
  dns_suffixes  = [ "fr.lab" ]
  dns_servers   = [ "10.1.3.1" ] 
  time_zone     = "MST7MDT"

  network_interface {
    label = "${var.network}"
  }

  disk {
    template  = "Template/TPL-CENTOS7"
    type      = "thin"
    datastore = "${var.datastore}"
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file("~/.ssh/fr")}"
  }

  provisioner "remote-exec" {
    inline = <<EOF
    ${data.template_file.init.rendered}
EOF
  }
}