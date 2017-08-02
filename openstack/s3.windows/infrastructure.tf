module "devwindows01" {
  source = "../modules/windows"

  name = "devwindows01"
  role = "windows"
  location = "portland"
  tenant_network = "portland_network"
  puppet_master_name = "puppet"
  puppet_master_ip = "192.168.1.2"
}

module "prodwindows01" {
  source = "../modules/windows"

  name = "prodwindows01"
  role = "windows"
  location = "chicago"
  tenant_network = "chicago_network"
  puppet_master_name = "puppet"
  puppet_master_ip = "192.168.1.2"
}
