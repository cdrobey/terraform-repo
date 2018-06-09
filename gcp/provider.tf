#--------------------------------------------------------------
# Provider Variables
#--------------------------------------------------------------
provider "google" {
  credentials = "${file("${var.gcp_auth_path}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}
