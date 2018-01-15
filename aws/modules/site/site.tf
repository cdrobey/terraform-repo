#--------------------------------------------------------------
# This module creates all site resources
#--------------------------------------------------------------

resource "aws_vpc" "awssite" {
    cidr_block = "${var.network0_cidr}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags {
      Name = "cdrobey-vpc"
      department = "tse"
      project = "Demo"
      created_by = "chris.roberson"
    }
}
resource "aws_subnet" "network0_subnet0" {
  vpc_id = "${aws_vpc.awssite.id}"
  cidr_block = "${var.network0_subnet0}"
  tags {
      Name = "cdrobey-subnet0"
      department = "tse"
      project = "Demo"
      created_by = "chris.roberson"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.awssite.id}"
  tags {
    Name = "cdrobey-igw"
    department = "tse"
    project = "Demo"
    created_by = "chris.roberson"
  } 
}

resource "aws_default_network_acl" "defaultnetworkacl" {
  default_network_acl_id = "${aws_vpc.awssite.default_network_acl_id}"

  egress {
    protocol = "-1"
    rule_no = 2
    action = "allow"
    cidr_block =  "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  ingress {
    protocol = "-1"
    rule_no = 1
    action = "allow"
    cidr_block =  "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
  tags {
    Name = "cdrobey-acl"
    department = "tse"
    project = "Demo"
    created_by = "chris.roberson"
  }
}
resource "aws_default_route_table" "defaultroute" {
  default_route_table_id = "${aws_vpc.awssite.default_route_table_id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "cdrobey-route"
    department = "tse"
    project = "Demo"
    created_by = "chris.roberson"
  }
}
resource "aws_default_security_group" "defaultsg" {
  vpc_id = "${aws_vpc.awssite.id}"

  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "4433"
    to_port     = "4433"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = "8081"
    to_port     = "8081"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = "8140"
    to_port     = "8143"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = "3389"
    to_port     = "3389"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = "8170"
    to_port     = "8170"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = "61613"
    to_port     = "61613"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5985
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "cdrobey-sg"
    department = "tse"
    project = "Demo"
    created_by = "chris.roberson"
  }
  
}
resource "aws_vpc_dhcp_options" "defaultdhcp" {
  domain_name          = "${var.domain}"
  domain_name_servers  = [ "AmazonProvidedDNS" ]
  tags {
    Name = "cdrobey-dhcp"
    department = "tse"
    project = "Demo"
    created_by = "chris.roberson"
  }
}

resource "aws_vpc_dhcp_options_association" "defaultresolver" {
  vpc_id = "${aws_vpc.awssite.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.defaultdhcp.id}"
}