#ps1_sysnative
$puppet_server = "master.inf.puppet.vm"
$agent_certname = Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/local-hostname
#Adding a host entry for the PE server
$host_entry = "$master_ip $puppet_server"
$host_entry | Out-File -FilePath C:\Windows\System32\Drivers\etc\hosts -Append -Encoding ascii
$master_uri = "http://${puppet_server}:81/deployed.txt"
#Wait for the master to be available before installing the agent
:loop while ($true) {
  $request = [System.Net.WebRequest]::Create($master_uri)
  $response = $request.GetResponse()
  switch ($response.StatusCode.value__)
  {
    200
      {
        #PUT A SPACE BETWEEN '{' and '$', OR THEY WILL TURN INTO '%'
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile("https://${puppet_server}:8140/packages/current/install.ps1", 'install.ps1')
        .\install.ps1 "main:certname=${agent_certname}"
        Write-Host "Installation has completed."
        break loop
      }
    default { Write-Host "Waiting for the installer to be available"; sleep 30 }
    }
}
