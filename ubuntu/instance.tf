resource "vsphere_virtual_machine" "centos" {
  name   = "${var.vmname}"
  vcpu   = 1
  memory = 1024
  domain = "${var.vmdomain}"
  datacenter = "${var.vmdc}"

  cluster = "${var.vmcluster}"

  network_interface {
    label = "${var.vmnetlabel}"
    ipv4_address = "${var.vmip}"
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
