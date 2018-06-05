#--------------------------------------------------------------
# This module creates all site resources
#--------------------------------------------------------------



output "subnet_id" {
  value = "${aws_subnet.network0_subnet0.id}"
}