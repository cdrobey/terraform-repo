#--------------------------------------------------------------
# This module creates all site resources
#--------------------------------------------------------------

output "network0_name" {
  value = "${google_compute_network.network0.name}"
}
