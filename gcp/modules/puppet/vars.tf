#--------------------------------------------------------------
# This module creates the puppet master resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Puppet Master Variables
#--------------------------------------------------------------
variable "name" {}

variable "project" {}
variable "region" {}
variable "ssh_user" {}
variable "ssh_key" {}
variable "image" {}
variable "network" {}
variable "git_pri_key" {}
variable "git_pub_key" {}
variable "git_url" {}
variable "eyaml_pri_key" {}
variable "eyaml_pub_key" {}

variable tag_name {
  default = "puppet"
}
