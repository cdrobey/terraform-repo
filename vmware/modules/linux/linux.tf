#--------------------------------------------------------------
# This module creates the linux server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Linux Variables
#--------------------------------------------------------------
variable "linux_name"       {}
variable "linux_domain"     {}
variable "linux_datacenter" {}
variable "linux_datastore"  {}
variable "linux_network"    {}
variable "master_name"      {}
variable "master_domain"    {}

#--------------------------------------------------------------
# Resources: Build Linux Configuration
#--------------------------------------------------------------
data "template_file" "init" {
    template = "${file("../bootstrap/bootstrap_pa.tpl")}"
    vars {
        linux_name  = "${var.linux_name}"
        linux_fqdn  = "${var.linux_name}.${var.linux_domain}"
        master_name = "${var.master_name}"
        master_fqdn = "${var.master_name}.${var.master_domain}"
    }
}

resource "vsphere_virtual_machine" "centos" {
  datacenter = "${var.linux_datacenter}"
  name   = "${var.linux_name}.${var.linux_domain}"

  vcpu   = 1
  memory = 1024

  network_interface {
    label = "${var.linux_network}"
  }

  disk {
    template = "Template/TPL-CENTOS7"
    type = "thin"
    datastore = "${var.linux_datastore}"
  }

  provisioner "remote-exec" {
    inline = <<EOF
${data.template_file.init.rendered}
EOF
    connection {
      type = "ssh"
      user = "deploy"
      private_key = "${file("~/.ssh/fr")}"
    }
  }
}
