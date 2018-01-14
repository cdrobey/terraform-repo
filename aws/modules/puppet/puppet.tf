#--------------------------------------------------------------
# This module creates the puppet master resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Resources: Build Puppet Master Configuration
#--------------------------------------------------------------
data "template_file" "init" {
    template = "${file("modules/puppet/bootstrap/bootstrap_pe.tpl")}"
    vars {
        master_name   = "${var.name}"
        master_fqdn   = "${var.name}.${var.domain}"
        git_pri_key   = "${file("${var.git_pri_key}")}"
        git_pub_key   = "${file("${var.git_pub_key}")}"
        git_url       = "${var.git_url}"
        eyaml_pri_key = "${file("${var.eyaml_pri_key}")}"
        eyaml_pub_key = "${file("${var.eyaml_pub_key}")}"
    }
}

resource "aws_instance" "puppet" {

  ami                         = "${var.ami}"
  instance_type               = "m1.large"
  associate_public_ip_address = "true"
  subnet_id                   = "${var.subnet_id}"
  key_name                    = "${var.sshkey}"

  tags {
    Name = "cdrobey-puppet"
    department = "tse"
    project = "Demo"
    created_by = "chris.roberson"
  }
  user_data = "${data.template_file.init.rendered}"
}