#--------------------------------------------------------------
# This module creates the puppet master resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Puppet Master Variables
#--------------------------------------------------------------
variable "name"          {}
variable "domain"        {}
variable "ami"           {}
variable "subnet_id"     {}
variable "sshkey"        {}
variable "sshkey_path"   {}
variable "git_pri_key"   {}
variable "git_pub_key"   {}
variable "git_url"       {}
variable "eyaml_pri_key" {}
variable "eyaml_pub_key" {}