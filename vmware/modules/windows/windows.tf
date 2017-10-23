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
variable "user_name"     {}
variable "password"      {}

#--------------------------------------------------------------
# Resources: Build win Configuration
#--------------------------------------------------------------
resource "vsphere_virtual_machine" "w2016" {
  datacenter    = "${var.datacenter}"
  name          = "${var.name}.${var.domain}"
  hostname      = "${var.name}"
  domain        = "${var.domain}"
  vcpu          = 2
  memory        = 4096
  dns_servers   = "${var.dns_servers}"
  dns_suffixes  = "${var.dns_suffixes}"

  network_interface {
    label = "${var.network}"
  }

  disk {
    template  = "Template/TPL-WIN16"
    type      = "thin"
    datastore = "${var.datastore}"
  }

  provisioner "file" {
    source      = "${path.module}/bootstrap/"
    destination = "C:\\Temp"
    connection  = {
      type        = "winrm"
      user        = "${var.user_name}"
      password    = "${var.password}"
    }
  }

  provisioner "remote-exec" {
    connection = {
      type        = "winrm"
      user        = "${var.user_name}"
      password    = "${var.password}"
    }
    inline = [
      "powershell.exe Set-ExecutionPolicy RemoteSigned -force",
      "powershell.exe -version 4 -ExecutionPolicy Bypass -File C:\\Temp\\bootstrap_win_pa.ps1"
    ]
  }
}
