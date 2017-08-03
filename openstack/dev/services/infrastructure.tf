module "puppet_master" {
  source = "../../modules/puppet_master"

  name = "puppet"
  domain = "infrastructure.vm"
  tenant_network = "portland_network"
  git_pri_key = "~/.ssh/slice_terraform"
  git_pub_key = "~/.ssh/slice_terraform.pub"
  git_url ="https://github.com/cdrobey/puppet-repo.git"
}

/*
module "devlinuxnode01" {
  source = "../../modules/linux"

  name = "devlinux01"
  domain = "portland.vm"
  tenant_network = "portland_network"
  puppet_master_name = "puppet"
  puppet_master_domain = "portland.vm"
  puppet_master_ip = "192.168.1.2"
}

module "prodlinuxnode02" {
  source = "../../modules/linux"

  name = "prodlinux01"
  domain = "chicago.vm"
  tenant_network = "chicago_network"
  puppet_master_name = "puppet"
  puppet_master_domain = "chicago.vm"
  puppet_master_ip = "192.168.1.2"
}
*/
