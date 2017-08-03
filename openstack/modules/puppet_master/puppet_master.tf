variable "name" {
  description = "The name of the service you are running"
}

variable "domain" {
  description = "The domain of this node - will be used to complete fqdn"
}

variable "openstack_keypair" {
  type        = "string"
  description = "The keypair to be used."
  default     = "slice_terraform"
}

variable "tenant_network" {
  type        = "string"
  description = "The network to be used."
  default     = "infrastructure_network"
}

variable "git_pri_key" {}

variable "git_pub_key" {}

variable "git_url" {}

resource "openstack_compute_floatingip_v2" "floating_ip" {
  pool = "ext-net-pdx1-opdx1"
}

data "template_file" "init_node" {
    template = "${file("../../bootstrap/bootstrap_pe.tpl")}"
    vars {
        master_name = "${var.name}"
        master_fqdn = "${var.name}.${var.domain}"
        master_ip   = "${openstack_compute_floatingip_v2.floating_ip.address}"
        git_pri_key = "${file("${var.git_pri_key}")}"
        git_pub_key = "${file("${var.git_pub_key}")}"
        git_url     = "${var.git_url}"

    }
}

resource "openstack_compute_instance_v2" "linux_node" {
  name              = "${var.name}.${var.domain}"
  image_name        = "centos_7_x86_64"
  availability_zone = "opdx1"
  flavor_name       = "m1.large"
  key_pair          = "${var.openstack_keypair}"
  security_groups   = ["default", "sg0"]

  network {
    name = "${var.tenant_network}"
    floating_ip = "${openstack_compute_floatingip_v2.floating_ip.address}"
    access_network = true
  }

  user_data = "${data.template_file.init_node.rendered}"
}

output "${var.name} ip address" {
  value = "${openstack_compute_floatingip_v2.floating_ip.address}"
}
