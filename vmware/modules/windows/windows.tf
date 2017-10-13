#--------------------------------------------------------------
# This module creates the win server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# win Variables
#--------------------------------------------------------------
variable "name"          {}
variable "domain"        {}
variable "datacenter"    {}
variable "datastore"     {}
variable "network"       {}
variable "master_name"   {}
variable "master_domain" {}
variable "dns_servers"   { type = "list" }
variable "dns_suffixes"  { type = "list"}
variable "time_zone"     {}

#--------------------------------------------------------------
# Resources: Build win Configuration
#--------------------------------------------------------------
/*data "template_file" "init" {
    template = "${file("../bootstrap/bootstrap_win_pa.tpl")}"
    vars {
        win_name    = "${var.name}"
        win_fqdn    = "${var.name}.${var.domain}"
        master_name = "${var.master_name}"
        master_fqdn = "${var.master_name}.${var.master_domain}"
    }
}
*/

resource "vsphere_virtual_machine" "w2016" {
  datacenter    = "${var.datacenter}"
  name          = "${var.name}.${var.domain}"
  hostname      = "${var.name}"
  domain        = "${var.domain}"
  vcpu          = 2
  memory        = 4096
  dns_servers   = "${var.dns_servers}"
  dns_suffixes  = "${var.dns_suffixes}"
  #time_zone     = "${var.time_zone}"  

  network_interface {
    label = "${var.network}"
  }

  disk {
    template  = "Template/TPL-WIN16"
    type      = "thin"
    datastore = "${var.datastore}"
  }
/*
  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file("~/.ssh/fr")}"
  }

  provisioner "remote-exec" {
    inline = <<EOF
    ${data.template_file.init.rendered}
EOF
  }*/
}
