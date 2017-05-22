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
  default = "LAB-C0"
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
  default = "Virtual"
}

//default Resource Pool
//variable "vmrp" {
//  default = "Virtual/labesx02.fr.lan"
//}

// default VM Template
variable "vmtemp" {
  default = "Templates/CENTOS7"
}

// default datastore cluster
variable "vmdatastore" {
  default = "DS-LAB-NFS01"
}

variable "vmiptest" {
  default = "10.1.1.1"
}

// map of the VM Network (vmdomain = "vmnetlabel")
variable "vmnetlabel" {
  default = "VM Network"
}
variable "vmip" {
  default = "10.1.3.9"
}
variable "vmmask" {
  default = "24"
}
variable "vmgateway" {
  default = "10.1.3.1"
}
variable "vmdns" {
  default = [ "10.1.3.1" ]
}

// default timezone for vm
variable "vmtz" {
  default = "America/Denver"

}
