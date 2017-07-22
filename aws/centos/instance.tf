resource "vsphere_virtual_machine" "centos" {

  count = "${var.vmcount}"

  name   = "${var.vmname}${count.index}"
  vcpu   = 1
  memory = 1024
  domain = "${var.vmdomain}"
  datacenter = "${var.vmdc}"

  cluster = "${var.vmcluster}"

  network_interface {
    label = "${var.vmnetlabel}"
  }

  dns_servers = "${var.vmdns}"

  disk {
    template = "${var.vmtemp}"
    type = "thin"
    datastore = "${var.vmdatastore}"
  }

  time_zone = "${var.vmtz}"

  provisioner "remote-exec" {
        inline = [
          "curl -k https://labpm.fr.lan:8140/packages/current/install.bash | sudo bash"
        ]
        connection {
            type = "ssh"
            user = "deploy"
            private_key = "${file("~/.ssh/id_rsa")}"
        }

    }

}
