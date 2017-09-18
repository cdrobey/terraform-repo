#--------------------------------------------------------------
# This module creates all site resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable datacenter      {}
variable cluster         {}
variable hosts           { default = [] }
variable network0        {}
variable network0_switch {}
variable datastore0      {}

#--------------------------------------------------------------
# Resources: VMWare Configuration
#--------------------------------------------------------------
data "vsphere_datacenter" "datacenter" {
  name = "${var.datacenter}"
}

#--------------------------------------------------------------
# Resources: Build Infrastructure for labvesx01
#--------------------------------------------------------------
data "vsphere_host" "host0" {
  name          = "${var.hosts[0]}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_host_port_group" "portgroup0" {
  name                = "${var.network0}"
  host_system_id      = "${data.vsphere_host.host0.id}"
  virtual_switch_name = "${var.network0_switch}"
}

#--------------------------------------------------------------
# Resources: Build Infrastructure for labvesx02
#--------------------------------------------------------------
data "vsphere_host" "host1" {
  name          = "${var.hosts[1]}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_host_port_group" "portgroup1" {
  name                = "${var.network0}"
  host_system_id      = "${data.vsphere_host.host1.id}"
  virtual_switch_name = "${var.network0_switch}"
}


#--------------------------------------------------------------
# Resources: Mount NFS Storage for ESX Servers
#--------------------------------------------------------------
data "vsphere_host" "hosts" {
  count         = "${length(var.hosts)}"
  name          = "${var.hosts[count.index]}"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_nas_datastore" "datastore" {
  name            = "${var.datastore0}"
  host_system_ids = ["${data.vsphere_host.hosts.*.id}"]

  type         = "NFS"
  remote_hosts = ["labdsm.fr.lab"]
  remote_path  = "/volume1/nfs01"
}
