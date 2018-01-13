resource "aws_vpc" "aws-demo" {
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
  vpc_id = "${aws_vpc.aws-demo.id}"
  cidr_block = "${var.network0_subnet0}"
  tags {
      Name = "cdrobey-subnet0"
      department = "tse"
      project = "Demo"
      created_by = "chris.roberson"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.aws-demo.id}"
  tags {
    Name = "cdrobey-igw"
    department = "tse"
    project = "Demo"
    created_by = "chris.roberson"
  } 
}


resource "aws_default_network_acl" "defaultnetworkacl" {
  default_network_acl_id = "${aws_vpc.aws-demo.default_network_acl_id}"

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
  default_route_table_id = "${aws_vpc.aws-demo.default_route_table_id}"
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
  vpc_id = "${aws_vpc.aws-demo.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
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

resource "aws_instance" "cdrobey-vm" {
  ami                         = "${var.linux_ami}"
  instance_type               = "t2.micro"
  associate_public_ip_address = "true"
  subnet_id                   = "${aws_subnet.network0_subnet0.id}"
  key_name                    = "${var.aws_sshkey}"

  tags {
    Name = "cdrobey-vm"
    department = "tse"
    project = "Demo"
    created_by = "chris.roberson"
  }
}