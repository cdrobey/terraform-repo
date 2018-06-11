#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable aws_access_key {}

variable aws_secret_key {}
variable aws_sshkey {}
variable aws_sshkey_path {}

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable region {
  default = "us-west-2"
}

variable vpc {
  default = "cdrobey-vpc"
}

variable network0_cidr {
  default = "10.1.0.0/16"
}

variable network0_subnet0 {
  default = "10.1.1.0/24"
}

variable network0_sg {
  default = "cdrobey_sg"
}

variable domain {
  default = "us-west-2.compute.internal"
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
  default = "cdrobey-puppet"
}

variable puppet_ami {
  default = "ami-6f68cf0f"
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
  default = "cdrobey-jenkins"
}

variable jenkins_ami {
  default = "ami-6f68cf0f"
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
  default = "cdrobey-linux"
}

variable linux_ami {
  default = "ami-6f68cf0f"
}

#--------------------------------------------------------------
# Windows Server Provisioning Variables
#--------------------------------------------------------------
variable windows_name {
  default = "cdrobey-window"
}

variable windows_ami {
  default = "ami-d7a114af"
}

variable windows_password {
  default = "Adm1nistrat0r"
}
