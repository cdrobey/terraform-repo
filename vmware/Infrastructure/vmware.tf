#--------------------------------------------------------------
# This module creates all demonstration resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Module: Build Vsphere Demonstration Site
#--------------------------------------------------------------
module "site" {
  source = "../modules/site"

  datacenter      = "${var.datacenter}"
  cluster         = "${var.cluster}"
  hosts           = "${var.hosts}"
  network0        = "${var.network0}"
  network0_switch = "${var.network0_switch}"
  datastore0      = "${var.datastore0}"
}