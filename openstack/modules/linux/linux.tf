#--------------------------------------------------------------
# This module creates the linux server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Linux Variables
#--------------------------------------------------------------
variable "linux_name"         {}
variable "linux_domain"       {}
variable "master_name"        {}
variable "master_domain"      {}
variable "master_ip"          {}
variable "openstack_keypair"  {}
variable "tenant_network"     {}

#--------------------------------------------------------------
# Resources: Build Linux Configuration
#--------------------------------------------------------------

resource "openstack_compute_floatingip_v2" "linux" {
  pool = "ext-net-pdx1-opdx1"
}

data "template_file" "linux" {
    template = "${file("../bootstrap/bootstrap_pa.tpl")}"
    vars {
        linux_name  = "${var.linux_name}"
        linux_fqdn  = "${var.linux_name}.${var.linux_domain}"
        linux_ip    = "${openstack_compute_floatingip_v2.linux.address}"
        master_name = "${var.master_name}"
        master_fqdn = "${var.master_name}.${var.master_domain}"
        master_ip   = "${var.master_ip}"
    }
}

resource "openstack_compute_instance_v2" "linux" {
  name              = "${var.linux_name}.${var.linux_domain}"
  image_name        = "centos_7_x86_64"
  availability_zone = "opdx1"
  flavor_name       = "m1.large"
  key_pair          = "${var.openstack_keypair}"
  security_groups   = ["default", "sg0"]


  network {
    name           = "${var.tenant_network}"
    floating_ip    = "${openstack_compute_floatingip_v2.linux.address}"
    access_network = true
  }

  user_data = "${data.template_file.linux.rendered}"
}

output "linux_ip" {
  value = "${openstack_compute_floatingip_v2.linux.address}"
}
