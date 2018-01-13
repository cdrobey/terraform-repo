#--------------------------------------------------------------
# Global Variables
#--------------------------------------------------------------
variable aws_access_key {}
variable aws_secret_key {}
variable aws_sshkey     {}

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable region             { default = "us-west-2" }
variable vpc                { default = "cdrobey-vpc" }
variable network0_cidr      { default = "10.1.0.0/16" }
variable network0_subnet0   { default = "10.1.1.0/24" }
variable network0_sg        { default = "cdrobey_sg" }
variable dns_suffixes       { default = [ "fr.lan"] }
variable time_zone          { default = "MST7MDT" }   

#--------------------------------------------------------------
# Puppet Master Provisioning Variables
#--------------------------------------------------------------
variable puppet_master_name       { default = "labpuppet" }
variable puppet_master_domain     { default = "fr.lan" }
variable git_pri_key              { default = "~/.ssh/github" }
variable git_pub_key              { default = "~/.ssh/github.pub" }
variable git_url                  { default = "https://github.com/cdrobey/puppet-repo" }
variable eyaml_pri_key            { default = "~/.eyaml/private_key.pkcs7.pem" }
variable eyaml_pub_key            { default = "~/.eyaml/public_key.pkcs7.pem" }

#--------------------------------------------------------------
# Jenkins Server Provisioning Variables
#--------------------------------------------------------------
variable jenkins_name     { default = "labjenkins" }
variable jenkins_domain   { default = "fr.lan" }

#--------------------------------------------------------------
# LINUX Server Provisioning Variables
#--------------------------------------------------------------
variable linux_name     { default = "lablinux" }
variable linux_domain   { default = "fr.lan" }
variable linux_ami      { default = "ami-6f68cf0f" }

#--------------------------------------------------------------
# Windows Server Provisioning Variables
#--------------------------------------------------------------
variable windows_name    { default = "labwindows" }
variable windows_domain  { default = "cdrobey.lan" }