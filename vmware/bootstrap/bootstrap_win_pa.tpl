#--------------------------------------------------------------
# This scripts bootstraps a windows node by installing a puppet
# agent.  Original code take from the Heat bootstrap.
#--------------------------------------------------------------
# Set Verbose Mode

#--------------------------------------------------------------
# Global Variables:
#   - PATH:       PATHs needed for command execution
#   - HOME:       Home Directory of script account
#   - PEINSTALL:  Command to install PE agent
#   - WORKDIR:    TMP directory for script
#   - LOGFILE:    Execution Log for bootstrap on client hosts
#--------------------------------------------------------------
$$HOME="C:\temp"
$$PEINSTALL="pe_install.ps1"
$$WORKDIR="C:\temp"
$$LOGFILE="bootstrap.log"

#--------------------------------------------------------------
# Redirect all stdout and stderr to logfile,
#--------------------------------------------------------------


#--------------------------------------------------------------
# Configure hostname and setup host file.
#--------------------------------------------------------------
function setup_host_name {
  echo "======================= Executing setup_host_name ======================="
  $$HOST_ENTRY = "${windows_ip} ${windows_name} ${windows_fqdn}"
  $$HOST_ENTRY | Out-File -FilePath C:\Windows\Systteem32\Drivers\etc\hosts -Append -Encoding ascii
  $$HOST_ENTRY = "${master_ip} ${master_name} ${master_fqdn}"
  $$HOST_ENTRY | Out-File -FilePath C:\Windows\System32\Drivers\etc\hosts -Append -Encoding ascii
}

#--------------------------------------------------------------
# Peform pre-agent installation tasks.
#--------------------------------------------------------------
function pre_install_pa {
  Write-Host "======================= Executing pre_install_pa ======================="
}

#--------------------------------------------------------------
# Peform post-agent installation tasks.
#--------------------------------------------------------------
function post_install_pa {
  Write-Host "======================= Executing pre_install_pa ======================="
}

#--------------------------------------------------------------
# Wait until PE console is fully operation and install PE
# agent.
#--------------------------------------------------------------
function install_pa {
  Write-Host "======================= Executing install_pa ======================="

  $$CERTNAME = Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/local-hostname

  :loop while ($$true) {
    $$request = [System.Net.WebRequest]::Create(http://${master_fqdn}:81/deployed.txt)
    $$response = $$request.GetResponse()
    switch ($$response.StatusCode.value__)
    {
      200
        {
          [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $$true }
          $$webClient = New-Object System.Net.WebClient
          $$webClient.DownloadFile("https://${master_fqdn}:8140/packages/current/windows-x86_64/puppet-agent-x64.msi, '$$PEINSTALL')
          .\$$PEINSTALL "main:certname=$${CERTNAME}"
          Write-Host "Installation has completed."
          break loop
        }
        default { Write-Host "Waiting for the installer to be available"; sleep 30 }
    }
  }
}

#--------------------------------------------------------------
# Initiate Puppet Run.
#--------------------------------------------------------------
function run_puppet {
  Write-Host "======================= Executing install_pa ======================="
  puppet agent -t
}

#--------------------------------------------------------------
# Main Script
#--------------------------------------------------------------
setup_host_name
pre_install_pa
install_pa
post_install_pa
run_puppet
