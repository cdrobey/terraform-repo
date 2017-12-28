#--------------------------------------------------------------
# Provider Variables
#--------------------------------------------------------------
provider "vsphere" {
  user                 = "${var.vsphere_user_name}"
  password             = "${var.vsphere_password}"
  vsphere_server       = "${var.vsphere_server}"
  allow_unverified_ssl = true
  version              = "~> 0.4.0"

}
