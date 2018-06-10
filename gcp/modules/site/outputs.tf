#--------------------------------------------------------------
# This module creates all site resources
#--------------------------------------------------------------

output "network" {
  value = "${google_compute_subnetwork.network0subnet0.name}"
}
