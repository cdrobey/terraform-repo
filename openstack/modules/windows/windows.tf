#--------------------------------------------------------------
# This module creates the windows server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Windows Variables
#--------------------------------------------------------------
variable "windows_name"       {}
variable "windows_domain"     {}
variable "master_name"        {}
variable "master_domain"      {}
variable "master_ip"          {}
variable "openstack_keypair"  {}
variable "tenant_network"     {}

#--------------------------------------------------------------
# Resources: Build Windows Configuration
#--------------------------------------------------------------
resource "openstack_compute_floatingip_v2" "windows" {
  pool = "ext-net-pdx1-opdx1"
}

data "template_file" "windows" {
    template = "${file("../bootstrap/bootstrap_win_pa.tpl")}"
    vars {
        windows_name  = "${var.windows_name}"
        windows_fqdn  = "${var.windows_name}.${var.windows_domain}"
        windows_ip    = "${openstack_compute_floatingip_v2.windows.address}"
        master_name   = "${var.master_name}"
        master_fqdn   = "${var.master_name}.${var.master_domain}"
        master_ip     = "${var.master_ip}"
    }
}

resource "openstack_compute_instance_v2" "windows" {
  name              = "${var.windows_name}.${var.windows_domain}"
  image_name        = "windows_2012_r2_std_eval_x86_64"
  availability_zone = "opdx1"
  flavor_name       = "g1.large"
  key_pair          = "${var.openstack_keypair}"
  security_groups   = ["default", "sg0"]


  network {
    name           = "${var.tenant_network}"
    floating_ip    = "${openstack_compute_floatingip_v2.windows.address}"
    access_network = true
  }

  user_data = "${data.template_file.windows.rendered}"
}

output "windows_ip" {
  value = "${openstack_compute_floatingip_v2.windows.address}"
}
