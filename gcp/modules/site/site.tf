#--------------------------------------------------------------
# This module creates all site resources
#--------------------------------------------------------------

resource "google_compute_network" "network0" {
  name                    = "network0"
  project                 = "${var.project}"
  auto_create_subnetworks = "false"
}

resource "google_compute_firewall" "network0fw" {
  name    = "networkfw0"
  project = "${var.project}"
  network = "${google_compute_network.network0.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_subnetwork" "network0subnet0" {
  name          = "network0subnet0"
  region        = "${var.region}"
  project       = "${var.project}"
  network       = "${google_compute_network.network0.name}"
  ip_cidr_range = "${var.network0_subnet0_cidr}"
}
