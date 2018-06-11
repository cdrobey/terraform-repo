#--------------------------------------------------------------
# This module creates all site resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Site Variables
#--------------------------------------------------------------
variable project {
  default = "cdrobey-puppet"
}

variable region {
  default = "us-east1"
}

variable zone {
  default = "us-east1-1b"
}

variable network0_cidr {
  default = "10.1.0.0/16"
}

variable network0_subnet0_cidr {
  default = "10.1.1.0/24"
}
