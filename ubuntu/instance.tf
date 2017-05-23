resource "vsphere_virtual_machine" "ubuntu" {

  count = "${var.vmcount}"

  name   = "${var.vmname}${count.index}"
  vcpu   = 1
  memory = 1024
  domain = "${var.vmdomain}"
  datacenter = "${var.vmdc}"

  cluster = "${var.vmcluster}"

  network_interface {
    label = "${var.vmnetlabel}"
    ipv4_address = "${var.vmip}${count.index}"
    ipv4_prefix_length = "${var.vmmask}"
    ipv4_gateway = "${var.vmgateway}"
  }

  dns_servers = "${var.vmdns}"

  disk {
    template = "${var.vmtemp}"
    type = "thin"
    datastore = "${var.vmdatastore}"
  }

  time_zone = "${var.vmtz}"
}
