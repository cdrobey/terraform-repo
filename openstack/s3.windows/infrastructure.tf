
module "base_network" {
  source = "./networking"
}

module "puppet_master" {
  source = "./puppet_master"

  control_repo         = "https://github/cdrobey/puppet-repo"
  ssh_pri_key          = "~/.ssh/github"
  ssh_pub_key          = "~/.ssh/github.pub"
}


module "linuxnode01" {
  source = "./linux_node"

  name = "linuxnode01"
  role = "linux"
  location = "portland"
  tenant_network = "portland_network"
}
