#--------------------------------------------------------------
# Resources: Module Instance Build
#--------------------------------------------------------------
data "template_file" "init" {
    template = "${file("modules/linux/bootstrap/bootstrap_linux_pa.tpl")}"
    vars {
        puppet_name     = "${var.puppet_name}"
        pp_role         = "${var.pp_role}"
        pp_application  = "${var.pp_application}"
        pp_environment  = "${var.pp_environment}"
    }
}

resource "aws_instance" "cdrobey-linux" {

  ami                         = "${var.ami}"
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id                   = "${var.subnet_id}"
  key_name                    = "${var.sshkey}"

  tags {
    Name = "${var.name}"
    department = "tse"
    project = "Demo"
    created_by = "chris.roberson"
  }
  user_data = "${data.template_file.init.rendered}"
}
