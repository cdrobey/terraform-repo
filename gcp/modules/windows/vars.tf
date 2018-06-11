#--------------------------------------------------------------
# This module creates the win server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# win Variables
#--------------------------------------------------------------
#--------------------------------------------------------------
# Module Variables
#--------------------------------------------------------------
#--------------------------------------------------------------
# This module creates the puppet master resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Puppet Master Variables
#--------------------------------------------------------------
variable "name" {}

variable "project" {}

variable "region" {}

variable "puppet_name" {}
variable "machine_type" {}
variable "image" {}
variable "network" {}
variable "pp_role" {}
variable "pp_environment" {}
variable "pp_application" {}

variable tag_name {
  default = "windows"
}
