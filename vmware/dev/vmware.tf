#--------------------------------------------------------------
# This module creates all demonstration resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Module: Build Vsphere Demonstration Site
#--------------------------------------------------------------
/*module "site" {
  source = "../modules/site"

  datacenter      = "${var.datacenter}"
  cluster         = "${var.cluster}"
  hosts           = "${var.hosts}"
  network0        = "${var.network0}"
  network0_switch = "${var.network0_switch}"
  datastore0      = "${var.datastore0}"
}
*/
#--------------------------------------------------------------
# Module: Build Puppet Master Server
#--------------------------------------------------------------
module "puppet_master" {
  source = "../modules/puppet_master"

  name        = "${var.puppet_master_name}"
  domain      = "${var.puppet_master_domain}"
  datacenter  = "${var.puppet_master_datacenter}"
  network     = "${var.puppet_master_network}"
  datastore   = "${var.puppet_master_datastore}"
  git_pri_key = "${var.git_pri_key}"
  git_pub_key = "${var.git_pub_key}"
  git_url     = "${var.git_url}"

}

#--------------------------------------------------------------
# Module: Build LINUX Server
#--------------------------------------------------------------
module "linux01" {
  source = "../modules/linux"

  name          = "${var.linux_name}"
  domain        = "${var.linux_domain}"
  datacenter    = "${var.datacenter}"
  datastore     = "${var.datastore0}"
  network       = "${var.network0}"
  master_name   = "${var.puppet_master_name}"
  master_domain = "${var.puppet_master_domain}"
}
/*
#--------------------------------------------------------------
# Module: Build Windows Server
#--------------------------------------------------------------
module "windows01" {
  source = "../modules/windows"

  windows_name      = "${var.windows_name}"
  windows_domain    = "${var.windows_domain}"
  master_name       = "${var.puppet_master_name}"
  master_domain     = "${var.puppet_master_domain}"
  master_ip         = "${module.puppet_master.puppet_master_ip}"
  tenant_network    = "${module.site.site_network}"
  openstack_keypair = "${var.openstack_keypair}"
}
*/
