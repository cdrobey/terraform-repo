module "puppet_master" {
  source = "../modules/puppet_master"

  control_repo         = "${var.control_repo}"
  git_pri_key          = "${var.git_pri_key}"
  git_pub_key          = "${var.git_pub_key}"
}
