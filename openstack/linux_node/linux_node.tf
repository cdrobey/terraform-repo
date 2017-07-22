variable "puppet_master_name" {
  description = "The fqdn of the puppet master"
  default = "puppet"
}

variable "puppet_master_location" {
  default = "infrastructure"
}

variable "puppet_master_ip" {
  description = "The IP address of the puppet master"
  default = "192.168.1.10"
}

variable "name" {
  description = "The name of the service you are running"
}

variable "role" {
  description = "The name of the role for the service"
}

variable "location" {
  description = "The location of this node - will be used to complete fqdn"
  default = "infrastructure"
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


resource "openstack_compute_floatingip_v2" "floating_ip" {
  pool = "ext-net-pdx1-opdx1"
}

data "template_file" "init_node" {
    template = "${file("bootstrap/bootstrap_agent.tpl")}"
    vars {
        role            = "${var.role}"
        name            = "${var.name}"
        location        = "${var.location}"
        master_name     = "${var.puppet_master_name}"
        master_location = "${var.puppet_master_location}"
        master_ip       = "${var.puppet_master_ip}"
    }
}

resource "openstack_compute_instance_v2" "linux_node" {
  name              = "${var.name}.${var.location}.lab"
  image_name        = "centos_7_x86_64"
  availability_zone = "opdx1"
  flavor_name       = "g1.medium"
  key_pair          = "${var.openstack_keypair}"
  security_groups   = ["default", "sg0"]

  network {
    name = "${var.tenant_network}"
    floating_ip = "${openstack_compute_floatingip_v2.floating_ip.address}"
    access_network = true
  }
  user_data = "${data.template_file.init_node.rendered}"
}
