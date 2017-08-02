module "devlinuxnode01" {
  source = "../modules/linux"

  name = "devlinux01"
  role = "linux"
  location = "portland"
  tenant_network = "portland_network"
  tenant_fip = "192.168.2.30"
}

module "prodlinuxnode02" {
  source = "../modules/linux"

  name = "prodlinux01"
  role = "linux"
  location = "chicago"
  tenant_network = "chicago_network"
  tenant_fip = "192.168.3.30"

}
