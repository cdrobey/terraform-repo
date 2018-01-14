#--------------------------------------------------------------
# This module creates the puppet master resources
#--------------------------------------------------------------

output "puppet_name" {
  value = "${aws_instance.puppet.private_dns}"
}