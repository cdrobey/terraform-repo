resource "openstack_networking_router_v2" "router" {
  name = "router"
  external_gateway = "1c66e248-4fcb-405a-be75-821f85fc3ddb"
  admin_state_up = "true"
}

resource "openstack_networking_network_v2" "infrastructure_network" {
  name = "infrastructure_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "infrastructure_subnet" {
  name = "infrastructure_subnet"
  network_id = "${openstack_networking_network_v2.infrastructure_network.id}"
  cidr = "192.168.1.0/24"
  ip_version = 4
  dns_nameservers = ["10.240.0.10", "10.240.1.10"]
}

resource "openstack_networking_router_interface_v2" "infrastructure_router_int" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.infrastructure_subnet.id}"
}

resource "openstack_networking_network_v2" "chicago_network" {
  name = "chicago_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "chicago_subnet" {
  name = "chicago_subnet"
  network_id = "${openstack_networking_network_v2.chicago_network.id}"
  cidr = "192.168.2.0/24"
  ip_version = 4
  dns_nameservers = ["10.240.0.10", "10.240.1.10"]
}

resource "openstack_networking_router_interface_v2" "chicago_router_int" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.chicago_subnet.id}"
}

resource "openstack_networking_network_v2" "portland_network" {
  name = "portland_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "portland_subnet" {
  name = "portland_subnet"
  network_id = "${openstack_networking_network_v2.portland_network.id}"
  cidr = "192.168.3.0/24"
  ip_version = 4
  dns_nameservers = ["10.240.0.10", "10.240.1.10"]
}

resource "openstack_networking_router_interface_v2" "portland_router_int" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.portland_subnet.id}"
}
