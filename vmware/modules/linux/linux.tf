#--------------------------------------------------------------
# This module creates the linux server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Linux Variables
#--------------------------------------------------------------
variable "name"           {}
variable "domain"         {}
variable "datacenter"     {}
variable "datastore"      {}
variable "network"        {}
variable "dns_servers"    { type = "list" }
variable "dns_suffixes"   { type = "list"}
variable "time_zone"      {}
variable "pp_role"        { default = "base"}
variable "pp_application" { default = "linux"}
variable "pp_environment" { default = "production"}

#--------------------------------------------------------------
# Resources: Build Linux Configuration
#--------------------------------------------------------------
resource "vsphere_virtual_machine" "linux" {
  datacenter    = "${var.datacenter}"
  name          = "${var.name}.${var.domain}"
  hostname      = "${var.name}"
  domain        = "${var.domain}"
  vcpu          = 1
  memory        = 1024
  dns_servers   = "${var.dns_servers}"
  dns_suffixes  = "${var.dns_suffixes}"
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

  provisioner "file" {
    source      = "${path.module}/bootstrap/bootstrap_linux_pa.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /tmp && sh bootstrap.sh ${var.pp_role} ${var.pp_environment} ${var.pp_application}"
    ]
  }
}
