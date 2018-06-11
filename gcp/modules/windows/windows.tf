#--------------------------------------------------------------
# This module creates the win server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Resources: Build win Configuration
#--------------------------------------------------------------
data "template_file" "init" {
  template = "${file("modules/windows/bootstrap/bootstrap_windows_pa.tpl")}"

  vars {
    puppet_name    = "${var.puppet_name}"
    password       = "Hello"
    pp_role        = "${var.pp_role}"
    pp_application = "${var.pp_application}"
    pp_environment = "${var.pp_environment}"
  }
}

data "google_compute_zones" "available" {
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "windows" {
  name         = "${var.name}"
  project      = "${var.project}"
  machine_type = "${var.machine_type}"
  zone         = "${data.google_compute_zones.available.names[0]}"

  tags = ["${var.tag_name}"]

  boot_disk {
    initialize_params {
      image = "${var.image}"
    }
  }

  network_interface {
    subnetwork         = "${var.network}"
    subnetwork_project = "${var.project}"

    access_config {}
  }

  #connection {
  #  type        = "winrm"
  #  user        = "${var.ssh_user}"
  #  private_key = "${file(var.ssh_key)}"
  #}

  #provisioner "file" {
  #  content     = "${data.template_file.init.rendered}"
  #  destination = "/tmp/bootstrap_pe.sh"
  #}

  #provisioner "remote-exec" {
  #  inline = [
  #    "sudo /usr/bin/sh /tmp/bootstrap_pe.sh",
  #  ]
  #}
}
