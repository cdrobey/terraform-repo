#--------------------------------------------------------------
# This module creates the linux server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Linux Variables
#--------------------------------------------------------------
variable "name"          {}
variable "domain"        {}
variable "datacenter"    {}
variable "datastore"     {}
variable "network"       {}
variable "master_name"   {}
variable "master_domain" {}
variable "dns_servers"   { type = "list" }
variable "time_zone"     {}

#--------------------------------------------------------------
# Resources: Build Linux Configuration
#--------------------------------------------------------------
data "template_file" "init" {
    template = "${file("../bootstrap/bootstrap_pa.tpl")}"
    vars {
        linux_name  = "${var.name}"
        linux_fqdn  = "${var.name}.${var.domain}"
        master_name = "${var.master_name}"
        master_fqdn = "${var.master_name}.${var.master_domain}"
    }
}

resource "vsphere_virtual_machine" "linux" {
  datacenter    = "${var.datacenter}"
  name          = "${var.name}.${var.domain}"
  domain        = "${var.domain}"
  vcpu          = 1
  memory        = 1024
  dns_servers   = "${var.dns_servers}"
  time_zone     = "${var.time_zone}"  

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