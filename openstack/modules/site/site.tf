#--------------------------------------------------------------
# This module creates all site resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable router         {}
variable network0       {}
variable subnet0        {}
variable network0_cidr  {}

#--------------------------------------------------------------
# Resources: Build Network Configuration
#--------------------------------------------------------------
resource "openstack_networking_router_v2" "router" {
  name = "${var.router}"
  external_gateway = "1c66e248-4fcb-405a-be75-821f85fc3ddb"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "network" {
  name = "${var.network0}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet" {
  name = "${var.subnet0}"
  network_id = "${openstack_networking_network_v2.network.id}"
  cidr = "${var.network0_cidr}"
  ip_version = 4
  dns_nameservers = ["10.240.0.10", "10.240.1.10"]
}

resource "openstack_networking_router_interface_v2" "router_int" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet.id}"
}

output "site_network" {
  value = "${openstack_networking_network_v2.network.name}"
}
