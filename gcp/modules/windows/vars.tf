#--------------------------------------------------------------
# This module creates the win server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# win Variables
#--------------------------------------------------------------
variable "name"           {}
variable "domain"         {}
variable "ami"            {}
variable "subnet_id"      {}
variable "sshkey"         {}
variable "sshkey_path"    {}
variable "puppet_name"    {}
variable "password"       {}
variable "pp_role"        {}
variable "pp_application" {}
variable "pp_environment" {}