module "devlinuxnode01" {
  source = "../modules/linux"

  name = "devlinux01"
  role = "linux"
  location = "portland"
  tenant_network = "portland_network"
}

module "prodlinuxnode02" {
  source = "../modules/linux"

  name = "prodlinux01"
  role = "linux"
  location = "chicago"
  tenant_network = "chicago_network"
}
