#--------------------------------------------------------------
# This module creates the puppet master resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Puppet Master Variables
#--------------------------------------------------------------
variable "name"               {}
variable "domain"             {}
variable "datacenter"         {}
variable "network"            {}
variable "datastore"          {}
variable "git_pri_key"        {}
variable "git_pub_key"        {}
variable "git_url"            {}

#--------------------------------------------------------------
# Resources: Build Puppet Master Configuration
#--------------------------------------------------------------
data "template_file" "init" {
    template = "${file("../bootstrap/bootstrap_pe.tpl")}"
    vars {
        master_name = "${var.name}"
        master_fqdn = "${var.name}.${var.domain}"
        git_pri_key = "${file("${var.git_pri_key}")}"
        git_pub_key = "${file("${var.git_pub_key}")}"
        git_url     = "${var.git_url}"
    }
}

resource "vsphere_virtual_machine" "centos" {
  datacenter = "${var.datacenter}"
  name   = "${var.name}.${var.domain}"

  vcpu          = 4
  memory        = 8192
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
    type = "ssh"
    user = "root"
    private_key = "${file("~/.ssh/fr")}"
  }

  provisioner "remote-exec" {
    inline = <<EOF
    ${data.template_file.init.rendered}
EOF
  }
}