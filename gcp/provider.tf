#--------------------------------------------------------------
# Provider Variables
#--------------------------------------------------------------
provider "google" {
  credentials = "${file("${var.gcp_auth_path}")}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}
