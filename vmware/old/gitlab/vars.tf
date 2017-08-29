variable "viuser" {
  default = ""
}
variable "vipassword" {
  default = ""
}
variable "viserver" {
  default = "vc.fr.lan"
}


// default VM name in vSphere and its hostname
variable "vmname" {
  default = "GIT"
}

// default VM domain for guest customization
variable "vmdomain" {
  default = "fr.lan"
}

// default VM DC to deploy vm
variable "vmdc" {
  default = "Colorado"
  }

// default compute cluster
variable "vmcluster" {
  default = "Physical"
}

// default VM Template
variable "vmtemp" {
  default = "Templates/TPL-CENTOS7"
}

// default datastore cluster
variable "vmdatastore" {
  default = "DS-R710-PROD01"
}

// map of the VM Network (vmdomain = "vmnetlabel")
variable "vmnetlabel" {
  default = "vS0EAN"
}

// default dns server for vm
variable "vmdns" {
  default = [ "10.1.3.1", "10.1.1.1" ]
}

// default timezone for vm
variable "vmtz" {
  default = "America/Denver"

}
