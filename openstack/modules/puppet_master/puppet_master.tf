variable "name" {
  description = "The name of the puppetmaster"
  default = "puppet"
}

variable "location" {
  description = "The location of this node - will be used to complete fqdn"
  default = "infrastructure"
}

variable "git_pri_key" {
  description = "The private key for code manager"
}

variable "git_pub_key" {
  description = "The public key for code manager"
}

variable "control_repo" {
  description = "puppet control repo for code manager"
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


resource "openstack_compute_floatingip_v2" "puppetip" {
  pool = "ext-net-pdx1-opdx1"
}


data "template_file" "init_puppetmaster" {
    template = "${file("../bootstrap/bootstrap_puppetmaster.tpl")}"
    vars {
        control_repo         = "${var.control_repo}"
        location             = "${var.location}"
        ssh_pri_key          = "${file("${var.git_pri_key}")}"
        ssh_pub_key          = "${file("${var.git_pub_key}")}"
        hostname             = "${var.name}"
    }
}

resource "openstack_compute_instance_v2" "puppet" {
  name              = "${var.name}.${var.location}.lab"
  image_name        = "centos_7_x86_64"
  availability_zone = "opdx1"
  flavor_name       = "m1.large"
  key_pair          = "${var.openstack_keypair}"
  security_groups   = ["default", "sg0"]

  network {
    name = "${var.tenant_network}"
    floating_ip = "${openstack_compute_floatingip_v2.puppetip.address}"
    access_network = true
  }

  provisioner "file" {
    content     = "${data.template_file.init_puppetmaster.rendered}"
    destination = "/tmp/bootstrap.sh"

    connection {
        type = "ssh"
        user = "centos"
        private_key = "${file("~/.ssh/slice_terraform")}"
    }
  }

/*  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/bootstrap.sh && sudo /tmp/bootstrap.sh"
    ]
    connection {
        type = "ssh"
        user = "centos"
            private_key = "${file("~/.ssh/slice_terraform")}"
        }
    }*/
}
