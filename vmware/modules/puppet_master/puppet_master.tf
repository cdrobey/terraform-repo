#--------------------------------------------------------------
# This module creates the puppet master resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Puppet Master Variables
#--------------------------------------------------------------
variable "name"               {}
variable "domain"             {}
variable "openstack_keypair"  {}
variable "tenant_network"     {}
variable "git_pri_key"        {}
variable "git_pub_key"        {}
variable "git_url"            {}

#--------------------------------------------------------------
# Resources: Build Puppet Master Configuration
#--------------------------------------------------------------

resource "openstack_compute_floatingip_v2" "puppet_master" {
  pool = "ext-net-pdx1-opdx1"
}

data "template_file" "puppet_master" {
    template = "${file("../bootstrap/bootstrap_pe.tpl")}"
    vars {
        master_name = "${var.name}"
        master_fqdn = "${var.name}.${var.domain}"
        master_ip   = "${openstack_compute_floatingip_v2.puppet_master.address}"
        git_pri_key = "${file("${var.git_pri_key}")}"
        git_pub_key = "${file("${var.git_pub_key}")}"
        git_url     = "${var.git_url}"
    }
}

resource "openstack_compute_instance_v2" "puppet_master" {
  name              = "${var.name}.${var.domain}"
  image_name        = "centos_7_x86_64"
  availability_zone = "opdx1"
  flavor_name       = "m1.large"
  key_pair          = "${var.openstack_keypair}"
  security_groups   = ["default", "sg0"]


  network {
    name           = "${var.tenant_network}"
    floating_ip    = "${openstack_compute_floatingip_v2.puppet_master.address}"
    access_network = true
  }

  user_data = "${data.template_file.puppet_master.rendered}"
}

output "puppet_master_ip" {
  value = "${openstack_compute_floatingip_v2.puppet_master.address}"
}
