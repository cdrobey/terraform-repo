As the greenfield VMs install their agent and connect to the Puppet Master, the code repository provides the baseline configuration policy.  Classification of the client VMs uses both the PE external node classifier, and the **site.pp**.  All VMs integrate trusted facts, pp_role, pp_application, and pp_environment, to instantiate an inital environment.  The dynamic classification allows changes to the greenfield VMs at time of installation.

Additionally, the Puppet Master bootstrap configures hiera eyaml for encryption of data.  During demonstration eyaml allows accounts to be created on target VMs without using cleartext passwords.  Prior to starting the enviroment execution, you must create the keys needs.  After gem installation on your local workstation, "gem install hiera-eyaml", the encryption certificates used for hiera must be created using the follow "eyaml createkeys".


This section defines the Puppet Master configuration environment.  The Puppet Environment builds a monolithic master using a series of Puppet Enterprise features.  The puppet_master bootstrap script configures code manager against an assigned puppet code repository.


This section describes the resources allocated to Jenkins server and client VMs. Depending on the deployment type, you may need to increase the resources to support the quantity of OSs.  The hostname and domain are needed values for each VM.  The name becomes the FQDN becomes the register system name within vCenter.