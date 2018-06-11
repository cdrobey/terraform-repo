#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable gcp_auth_path {}

variable gcp_ssh_user {}
variable gcp_ssh_key {}

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable region {
  default = "us-east1"
}

variable project {
  default = "cdrobey-puppet"
}

variable network0_cidr {
  default = "10.1.0.0/16"
}

variable network0_subnet0_cidr {
  default = "10.1.1.0/24"
}

#--------------------------------------------------------------
# Instance Variables
#--------------------------------------------------------------
variable pp_role {
  default = "base"
}

variable pp_environment {
  default = "feature"
}

variable pp_application {
  default = "generic"
}

#--------------------------------------------------------------
# Puppet Master Provisioning Variables
#--------------------------------------------------------------
variable puppet_name {
  default = "puppet"
}

variable puppet_image {
  default = "centos-cloud/centos-7"
}

variable git_pri_key {
  default = "~/.ssh/github"
}

variable git_pub_key {
  default = "~/.ssh/github.pub"
}

variable git_url {
  default = "https://github.com/cdrobey/puppet-repo"
}

variable eyaml_pri_key {
  default = "~/.eyaml/private_key.pkcs7.pem"
}

variable eyaml_pub_key {
  default = "~/.eyaml/public_key.pkcs7.pem"
}

#--------------------------------------------------------------
# Jenkins Server Provisioning Variables
#--------------------------------------------------------------
variable jenkins_name {
  default = "jenkins"
}

variable jenkins_machine_type {
  default = "n1-standard-1"
}

variable jenkins_image {
  default = "centos-cloud/centos-7"
}

variable jenkins_pp_role {
  default = "jenkins"
}

variable jenkins_pp_application {
  default = "jenkins"
}

variable jenkins_pp_environment {
  default = "feature"
}

#--------------------------------------------------------------
# LINUX Server Provisioning Variables
#--------------------------------------------------------------
variable linux_name {
  default = "linux"
}

variable linux_machine_type {
  default = "g1-small"
}

variable linux_image {
  default = "centos-cloud/centos-7"
}

#--------------------------------------------------------------
# Windows Server Provisioning Variables
#-------------------------------------------------------------

variable windows_name {
  default = "windows"
}

variable windows_machine_type {
  default = "g1-small"
}

variable windows_image {
  default = "windows-cloud/windows-server-2012-r2-dc-v20180508"
}

variable windows_password {
  default = "Adm1nistrat0r"
}

