#--------------------------------------------------------------
# This module creates all demonstration resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Module: Create Site Infrastructure
#--------------------------------------------------------------
module "site" {
  source                = "modules/site"
  project               = "${var.project}"
  region                = "us-east1"
  network0_cidr         = "${var.network0_cidr}"
  network0_subnet0_cidr = "${var.network0_subnet0_cidr}"
  domain                = "${var.domain}"
}

#--------------------------------------------------------------
# Module: Build Puppet Master Server
#--------------------------------------------------------------
module "puppet" {
  source        = "modules/puppet"
  name          = "${var.puppet_name}"
  project       = "${var.project}"
  region        = "us-east1"
  domain        = "${var.domain}"
  image         = "${var.puppet_image}"
  network       = "${module.site.network}"
  git_pri_key   = "${var.git_pri_key}"
  git_pub_key   = "${var.git_pub_key}"
  git_url       = "${var.git_url}"
  eyaml_pri_key = "${var.eyaml_pri_key}"
  eyaml_pub_key = "${var.eyaml_pub_key}"
}

#--------------------------------------------------------------
# Module: Build Linux Server
#--------------------------------------------------------------
#module "linux01" {
#  source = "modules/linux"
#
#  name           = "${var.linux_name}01"
#  domain         = "${var.domain}"
#  ami            = "${var.puppet_ami}"
#  subnet_id      = "${module.site.subnet_id}"
#  sshkey         = "${var.aws_sshkey}"
#  sshkey_path    = "${var.aws_sshkey_path}"
#  puppet_name    = "${module.puppet.puppet_name}"
#  pp_role        = "${var.pp_role}"
#  pp_application = "${var.pp_application}"
#  pp_environment = "${var.pp_environment}"
#}


##--------------------------------------------------------------
## Module: Build Jenkins Server
##--------------------------------------------------------------
#module "jenkins" {
#  source = "modules/jenkins"
#
#  name           = "${var.jenkins_name}"
#  domain         = "${var.domain}"
#  ami            = "${var.puppet_ami}"
#  subnet_id      = "${module.site.subnet_id}"
#  sshkey         = "${var.aws_sshkey}"
#  sshkey_path    = "${var.aws_sshkey_path}"
#  puppet_name    = "${module.puppet.puppet_name}"
#  pp_role        = "${var.jenkins_pp_role}"
#  pp_application = "${var.jenkins_pp_application}"
#  pp_environment = "${var.jenkins_pp_environment}"
#}
#
##--------------------------------------------------------------
## Module: Build Windows Server
##--------------------------------------------------------------
#module "windows01" {
#  source = "modules/windows"
#
#  name           = "${var.windows_name}01"
#  domain         = "${var.domain}"
#  ami            = "${var.windows_ami}"
#  subnet_id      = "${module.site.subnet_id}"
#  sshkey         = "${var.aws_sshkey}"
#  sshkey_path    = "${var.aws_sshkey_path}"
#  puppet_name    = "${module.puppet.puppet_name}"
#  password       = "${var.windows_password}"
#  pp_role        = "${var.pp_role}"
#  pp_application = "${var.pp_application}"
#  pp_environment = "${var.pp_environment}"
#}

