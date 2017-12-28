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
variable "dns_suffixes"  { type = "list"}
variable "time_zone"     {}

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
    source      = "${path.module}/bootstrap/"
    destination = "C:\\Temp"
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe Set-ExecutionPolicy RemoteSigned -force",
      "echo ${var.pp_role} > C:\\Temp\\csr.txt",
      "echo ${var.pp_application} >> C:\\Temp\\csr.txt",
      "echo ${var.pp_environment} >> C:\\Temp\\csr.txt",
      "powershell.exe -version 4 -ExecutionPolicy Bypass -File C:\\Temp\\bootstrap_win_pa.ps1"
    ]
  }
}
