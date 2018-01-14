#--------------------------------------------------------------
# This module creates all demonstration resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Module: Create Site Infrastructure
#--------------------------------------------------------------
module "site" {
  source = "modules/site"

  network0_cidr    = "${var.network0_cidr}"
  network0_subnet0 = "${var.network0_subnet0}"
  domain           = "${var.domain}"
}

#--------------------------------------------------------------
# Module: Build Puppet Master Server
#--------------------------------------------------------------
module "puppet" {
  source = "modules/puppet"

  name          = "${var.puppet_master_name}"
  domain        = "${var.puppet_master_domain}"
  ami           = "${var.puppet_master_ami}"
  subnet_id     = "${module.site.subnet_id}"
  sshkey        = "${var.aws_sshkey}"
  sshkey_path   = "${var.aws_sshkey_path}"
  git_pri_key   = "${var.git_pri_key}"
  git_pub_key   = "${var.git_pub_key}"
  git_url       = "${var.git_url}"
  eyaml_pri_key = "${var.eyaml_pri_key}"
  eyaml_pub_key = "${var.eyaml_pub_key}"
}

#--------------------------------------------------------------
# Module: Build Linux Server
#--------------------------------------------------------------
module "linux01" {
  source = "modules/linux"

  name           = "${var.linux_name}01"
  domain         = "${var.puppet_master_domain}"
  ami            = "${var.puppet_master_ami}"
  subnet_id      = "${module.site.subnet_id}"
  sshkey         = "${var.aws_sshkey}"
  sshkey_path    = "${var.aws_sshkey_path}"
  puppet_name    = "${module.puppet.puppet_name}"
  pp_role        = "${var.pp_role}"
  pp_application = "${var.pp_application}"
  pp_environment = "${var.pp_environment}"
}