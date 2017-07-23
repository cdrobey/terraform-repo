resource "openstack_compute_floatingip_v2" "floating_ip" {
  pool = "ext-net-pdx1-opdx1"
}

data "template_file" "init_node" {
    template = "${file("bootstrap/bootstrap_agent.tpl")}"
    vars {
        role            = "${var.l_role}"
        name            = "${var.l_name}"
        location        = "${var.l_location}"
        master_name     = "${var.l_pm_name}"
        master_location = "${var.l_pm_location}"
        master_ip       = "${var.l_pm_ip}"
    }
}

resource "openstack_compute_instance_v2" "linux_node" {
  name              = "${var.l_name}.${var.l_location}.lab"
  image_name        = "centos_7_x86_64"
  availability_zone = "opdx1"
  flavor_name       = "g1.medium"
  key_pair          = "${var.openstack_keypair}"
  security_groups   = ["default", "sg0"]

  network {
    name = "${var.l_tenant_network}"
    floating_ip = "${openstack_compute_floatingip_v2.floating_ip.address}"
    access_network = true
  }
  provisioner "file" {
    content     = "${data.template_file.init_node.rendered}"
    destination = "/tmp/pm.sh"

    connection {
        type = "ssh"
        user = "centos"
        private_key = "${file("~/.ssh/slice_terraform")}"
    }
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/pm.sh && sudo /tmp/pm.sh"
    ]
    connection {
        type = "ssh"
        user = "centos"
            private_key = "${file("~/.ssh/slice_terraform")}"
        }
    }
  }
