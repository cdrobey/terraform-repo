#--------------------------------------------------------------
# This module creates the win server resources
#--------------------------------------------------------------

#--------------------------------------------------------------
# Resources: Build win Configuration
#--------------------------------------------------------------

resource "aws_instance" "w2016" {
  connection {
    type     = "winrm"
    user     = "Administrator"
    password = "${var.password}"
    # set from default of 5m to 10m to avoid winrm timeout
    timeout  = "10m"
  }

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

  # Note that terraform uses Go WinRM which doesn't support https at this time. If server is not on a private network,
  # recommend bootstraping Chef via user_data.  See asg_user_data.tpl for an example on how to do that.
  user_data = <<EOF
<script>
  winrm quickconfig -q & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
</script>
<powershell>
  netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
  # Set Administrator password
  $admin = [adsi]("WinNT://./administrator, user")
  $admin.psbase.invoke("SetPassword", "${var.password}")
</powershell>
EOF
}
