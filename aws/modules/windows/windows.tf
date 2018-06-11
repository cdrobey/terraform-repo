#--------------------------------------------------------------
# This module creates the win server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Resources: Build win Configuration
#--------------------------------------------------------------
data "template_file" "init" {
  template = "${file("modules/windows/bootstrap/bootstrap_windows_pa.tpl")}"

  vars {
    puppet_name    = "${var.puppet_name}"
    password       = "${var.password}"
    pp_role        = "${var.pp_role}"
    pp_application = "${var.pp_application}"
    pp_environment = "${var.pp_environment}"
  }
}

resource "aws_instance" "w2016" {
  connection {
    type     = "winrm"
    user     = "Administrator"
    password = "${var.password}"

    # set from default of 5m to 10m to avoid winrm timeout
    timeout = "10m"
  }

  ami                         = "${var.ami}"
  instance_type               = "t2.small"
  associate_public_ip_address = "true"
  subnet_id                   = "${var.subnet_id}"
  key_name                    = "${var.sshkey}"

  tags {
    Name       = "${var.name}"
    department = "tse"
    project    = "Demo"
    created_by = "chris.roberson@puppet.com"
    lifetime   = "26w"
  }

  user_data = "${data.template_file.init.rendered}"
}
