module "linuxnode01" {
  source = "../modules/linux"

  name = "linux01"
  role = "linux"
  location = "portland"
  tenant_network = "portland_network"
}
