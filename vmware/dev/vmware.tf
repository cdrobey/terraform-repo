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

  name         = "${var.puppet_master_name}"
  domain       = "${var.puppet_master_domain}"
  datacenter   = "${var.puppet_master_datacenter}"
  network      = "${var.puppet_master_network}"
  datastore    = "${var.puppet_master_datastore}"
  dns_servers  = "${var.dns_servers}"   
  time_zone    = "${var.time_zone}"   
  git_pri_key  = "${var.git_pri_key}"
  git_pub_key  = "${var.git_pub_key}"
  git_url      = "${var.git_url}"

}

#--------------------------------------------------------------
# Module: Build Jenkins Server
#--------------------------------------------------------------
module "jenkins" {
  source = "../modules/linux"

  name          = "${var.jenkins_name}"
  domain        = "${var.jenkins_domain}"
  datacenter    = "${var.datacenter}"
  datastore     = "${var.datastore0}"
  dns_servers   = "${var.dns_servers}"   
  dns_suffixes  = "${var.dns_suffixes}"   
  time_zone     = "${var.time_zone}" 
  network       = "${var.network0}"
  master_name   = "${var.puppet_master_name}"
  master_domain = "${var.puppet_master_domain}"
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
  dns_servers   = "${var.dns_servers}"   
  dns_suffixes  = "${var.dns_suffixes}"   
  time_zone     = "${var.time_zone}" 
  network       = "${var.network0}"
  master_name   = "${var.puppet_master_name}"
  master_domain = "${var.puppet_master_domain}"
}

module "linux02" {
  source = "../modules/linux"

  name          = "${var.linux_name}d01"
  domain        = "${var.linux_domain}"
  datacenter    = "${var.datacenter}"
  datastore     = "${var.datastore0}"
  dns_servers   = "${var.dns_servers}"   
  dns_suffixes  = "${var.dns_suffixes}"   
  time_zone     = "${var.time_zone}" 
  network       = "${var.network0}"
  master_name   = "${var.puppet_master_name}"
  master_domain = "${var.puppet_master_domain}"
}
#--------------------------------------------------------------
# Module: Build Windows Server
#--------------------------------------------------------------
module "windows01" {
  source = "../modules/windows"

  name          = "${var.windows_name}"
  domain        = "${var.windows_domain}"
  datacenter    = "${var.datacenter}"
  datastore     = "${var.datastore0}"
  dns_servers   = "${var.dns_servers}"   
  dns_suffixes  = "${var.dns_suffixes}"   
  time_zone     = "${var.time_zone}" 
  network       = "${var.network0}"
  master_name   = "${var.puppet_master_name}"
  master_domain = "${var.puppet_master_domain}"
  user_name     = "${var.windows_user_name}"
  password      = "${var.windows_password}"
}

module "windows02" {
  source = "../modules/windows"

  name          = "${var.windows_name}d01"
  domain        = "${var.windows_domain}"
  datacenter    = "${var.datacenter}"
  datastore     = "${var.datastore0}"
  dns_servers   = "${var.dns_servers}"   
  dns_suffixes  = "${var.dns_suffixes}"   
  time_zone     = "${var.time_zone}" 
  network       = "${var.network0}"
  master_name   = "${var.puppet_master_name}"
  master_domain = "${var.puppet_master_domain}"
  user_name     = "${var.windows_user_name}"
  password      = "${var.windows_password}"
}
