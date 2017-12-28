#--------------------------------------------------------------
# This scripts bootstraps a windows node by installing a puppet
# agent.  Original code taken from the Heat bootstrap.
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
$PEINSTALL_FILE="c:\pe_install.ps1"
$PEINSTALL_URL="https://labpuppet:8140/packages/current/install.ps1"

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

  :loop while ($true) {  
    [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} 
    $webclient = New-Object system.net.webclient
    $webclient.DownloadFile($PEINSTALL_URL,$PEINSTALL_FILE)
    if(Test-Path $PEINSTALL_FILE){
      Write-Verbose "Starting Installation"
      invoke-expression $PEINSTALL_FILE   
      break loop 
    }
    else {
      Write-Verbose "Waiting on PuppetMaster"
	  sleep 30
    }
  }
}

#--------------------------------------------------------------
# Initiate Puppet Run.
#--------------------------------------------------------------
function run_puppet {
  Write-Host "======================= Executing install_pa ======================="
  #puppet agent -t
}

#--------------------------------------------------------------
# Main Script
#--------------------------------------------------------------
pre_install_pa
install_pa
post_install_pa
run_puppet