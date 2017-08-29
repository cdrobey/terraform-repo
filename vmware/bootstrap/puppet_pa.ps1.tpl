# This script will run the Puppet agent until we get a successful run with no changes.
$LAST_RUN_REPORT = "C:\ProgramData\PuppetLabs\puppet\cache\state\last_run_report.yaml"
$BINPUPPET = "C:\Program Files\Puppet Labs\Puppet\bin"
$FAILPOINT = 32 # Fail with this number of run failures
$SLEEPTIME = 8 # number of seconds to wait before another run
$PUPPET_MASTER_NAME = "master.inf.puppet.vm"
$MSI_SOURCE = "https://${puppet_master_server}:8140/packages/current/windows-x86_64/puppet-agent-x64.msi"
$MSI_DEST = "C:\tmp\puppet-agent-x64.msi"

function set_hostname {
  # Determine system hostname and primary DNS suffix to determine CERTNAME
  $OBJIPPROPERTIES = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
  $NAME_COMPONENTS = @($OBJIPPROPERTIES.HostName, $OBJIPPROPERTIES.DomainName) | ? {$_}
  $CERTNAME = $NAME_COMPONENTS -Join "."
}

Function install_pa { Param( $url, $file)
  Get-WebPage -url $MSI_SOURCE -file $MSI_DEST -force

  if ($Result.ExitCode -eq 0)
  {
    $MSIEXEC_PATH = "C:\Windows\System32\msiexec.exe"
    $MSIEXEC_ARGS = "/qn /log c:\log.txt /i $MSI_DEST PUPPET_MASTER_SERVER=$puppet_master_server PUPPET_AGENT_CERTNAME=$CERTNAME"
    $MSIEXEC_PROC = [System.Diagnostics.Process]::Start($MSIEXEC_PATH, $MSIEXEC_ARGS)
    $MSIEXEC_PROC.WaitForExit()
  }

}

function main {
 $puppet_runs = 0 # Keep track of number of Puppet runs
 $puppet_tries = $FAILPOINT
 $puppetrun_exitcode = 0
 $puppetrun_status = get_pupstatus

  # Bypass if last Puppet run was successful...
  if ($puppetrun_status -eq "unchanged") {write "Last Puppet run was successful, continuing..."}


  # ... otherwise, loop through until we get a good run or run too many times.
  while ($puppetrun_status -ne "unchanged" ) {

    $Puppet_Exists = Test-Path $BINPUPPET
    if ($Puppet_Exists -eq $false) {
      write "Puppet doesn't appear to have installed correctly.  Exiting script."
      exit 1
    }


    puppet agent -t > $null
    $puppetrun_exitcode = $LastExitCode

    if ( $puppetrun_exitcode -eq 1 ) {
      write "Puppet run failed or run may be in progress. Trying ${$puppet_tries} more time(s)."
    }


    (($puppet_runs++))
    (($puppet_tries--))

    if ($puppet_runs -eq $FAILPOINT) {
      write "Too many Puppet run failures, bailing script.  Could just be an exec resource, or... ?"
      exit 1
    }


    # Get last run status again.  If we're successful, script is done, otherwise, sleep it off.
    $puppetrun_status = get_pupstatus

    if ( "$puppetrun_status" -eq "unchanged" ) {
      write  "Puppet run successful."
      exit 0
    } else {
      $SLEEPTIME
    }
  }

}

#main
set_hostname
install_pa -url $MSI_SOURCE -file $MSI_DEST
