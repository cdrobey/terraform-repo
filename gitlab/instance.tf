resource "vsphere_virtual_machine" "centos" {

  name   = "${var.vmname}"
  vcpu   = 2
  memory = 2048
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
          "curl -k https://pm.fr.lan:8140/packages/current/install.bash | sudo bash"
        ]
        connection {
            type = "ssh"
            user = "deploy"
            private_key = "${file("~/.ssh/fr.lan_id_rsa")}"
        }

    }

}
