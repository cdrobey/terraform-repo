#--------------------------------------------------------------
# This module creates all demonstration resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Module: Build Puppet Master Server
#--------------------------------------------------------------
module "puppet_master" {
  source = "modules/puppet_master"

  name          = "${var.puppet_master_name}"
  domain        = "${var.puppet_master_domain}"
  datacenter    = "${var.datacenter}"
  network       = "${var.network0}"
  datastore     = "${var.datastore0}"
  dns_servers   = "${var.dns_servers}"   
  time_zone     = "${var.time_zone}"   
  git_pri_key   = "${var.git_pri_key}"
  git_pub_key   = "${var.git_pub_key}"
  git_url       = "${var.git_url}"
  eyaml_pri_key = "${var.eyaml_pri_key}"
  eyaml_pub_key = "${var.eyaml_pub_key}"
}

#--------------------------------------------------------------
# Module: Build Jenkins Server
#--------------------------------------------------------------
module "jenkins" {
  source = "modules/linux"

  name          = "${var.jenkins_name}"
  domain        = "${var.jenkins_domain}"
  datacenter    = "${var.datacenter}"
  datastore     = "${var.datastore0}"
  dns_servers   = "${var.dns_servers}"   
  dns_suffixes  = "${var.dns_suffixes}"   
  time_zone     = "${var.time_zone}" 
  network       = "${var.network0}"
  pp_role        = "jenkins"
  pp_application = "ci"
  pp_environment = "production"
}

#--------------------------------------------------------------
# Module: Build LINUX Server
#--------------------------------------------------------------
module "linux01" {
  source = "modules/linux"

  name          = "${var.linux_name}01"
  domain        = "${var.linux_domain}"
  datacenter    = "${var.datacenter}"
  datastore     = "${var.datastore0}"
  dns_servers   = "${var.dns_servers}"   
  dns_suffixes  = "${var.dns_suffixes}"   
  time_zone     = "${var.time_zone}" 
  network       = "${var.network0}"
}

module "linux02" {
  source = "modules/linux"

  name           = "${var.linux_name}02"
  domain         = "${var.linux_domain}"
  datacenter     = "${var.datacenter}"
  datastore      = "${var.datastore0}"
  dns_servers    = "${var.dns_servers}"   
  dns_suffixes   = "${var.dns_suffixes}"   
  time_zone      = "${var.time_zone}" 
  network        = "${var.network0}"
  pp_role        = "apache"
  pp_application = "webserver"
  pp_environment = "production"
}
#--------------------------------------------------------------
# Module: Build Windows Server
#--------------------------------------------------------------
module "windows01" {
  source = "modules/windows"

  name          = "${var.windows_name}01"
  domain        = "${var.windows_domain}"
  datacenter    = "${var.datacenter}"
  datastore     = "${var.datastore0}"
  dns_servers   = "${var.dns_servers}"   
  dns_suffixes  = "${var.dns_suffixes}"   
  time_zone     = "${var.time_zone}" 
  network       = "${var.network0}"
  user_name     = "${var.windows_user_name}"
  password      = "${var.windows_password}"
}
module "windows02" {
  source = "modules/windows"

  name          = "${var.windows_name}02"
  domain        = "${var.windows_domain}"
  datacenter    = "${var.datacenter}"
  datastore     = "${var.datastore0}"
  dns_servers   = "${var.dns_servers}"   
  dns_suffixes  = "${var.dns_suffixes}"   
  time_zone     = "${var.time_zone}" 
  network       = "${var.network0}"
  user_name     = "${var.windows_user_name}"
  password      = "${var.windows_password}"
  pp_role        = "iis"
  pp_application = "webserver"
  pp_environment = "production"
}