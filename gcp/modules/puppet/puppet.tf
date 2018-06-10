#--------------------------------------------------------------
# This module creates the puppet master resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Resources: Build Puppet Master Configuration
#--------------------------------------------------------------
data "template_file" "init" {
  template = "${file("modules/puppet/bootstrap/bootstrap_pe.tpl")}"

  vars {
    master_name   = "${var.name}"
    master_fqdn   = "${var.name}.${var.domain}"
    git_pri_key   = "${file("${var.git_pri_key}")}"
    git_pub_key   = "${file("${var.git_pub_key}")}"
    git_url       = "${var.git_url}"
    eyaml_pri_key = "${file("${var.eyaml_pri_key}")}"
    eyaml_pub_key = "${file("${var.eyaml_pub_key}")}"
  }
}

data "google_compute_zones" "available" {
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "puppet" {
  name         = "${var.name}"
  project      = "${var.project}"
  machine_type = "n1-standard-1"
  zone         = "${data.google_compute_zones.available.names[0]}"

  #zone         = "us-central1-a"

  tags = ["${var.tag_name}"]
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }
  // Local SSD disk
  scratch_disk = {}
  network_interface {
    subnetwork         = "${var.network}"
    subnetwork_project = "${var.project}"

    access_config {
      // Ephemeral IP
    }
  }

  #user_data = "${data.template_file.init.rendered}"
}
