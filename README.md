# HomeLab VM and Puppet Build

## Table of Contents

* [Description](#description)
* [Changelog](#changelog)
* [Requirements](#requirements)
* [Supported Deployments](#supported-deployments)
* [Scripts](#scripts)
* [Configuration](#configuration)
* [Logging](#logging)
* [Verification](#verification)
* [Acknowledgement](#acknowledgement)

## Description

This repository leverages Terraform and Puppet Enterprise to build a platform for customer demostrations.  I use the Terraform code to build out a set of VMs that setup a Puppet Console and Jenkins Servers.  The servers utilize a [puppet code repository] (https://github.com/cdrobey/puppet-repo) that support a set of baseline and application configurations for Puppet.

The scripting requires a set of VM templates for Centos and Windows 2016 to perform a deployment.  THe initial environment supports the Terraform vsphere provider.  The provider requires an ESX environment managed by vCenter.  I use a nested VM environment on a single server for deployment built using a [customized git repository] (https://github.com/cdrobey/nestedlab-repo).


## Changelog

### **12/28/17**

* Created the intial README to provide details on instruction and setup
* Performed testing and validation of demonstration environment deployment
* Integrated eyaml for password encryption of environment
* Migrated folder based dev/prod/test environment to git branching workflow.

## Requirements

* 3 x Gold Images for different operating systems: Centos 7, Ubuntu 16.04, and Windows 2016
* MacOS 10.11 or Later
* Terraform v0.11.1
* vCenter Server Appliance (VCSA) 6.5 extracted ISO

## Supported Deployments

The script supports deploying six VM with the demonstration environment.  A Puppet Enterprise console/master, Jenkins Server, and a set of target VMs.  The target VMs  provide a greenfield environement of two linux and windows system.

## Configuration

This section describes the location of the hidden provider files with secured credential for the vmware provider.  The **vmware/terraform.tfvars** file requires details of the vcenter environment and needs windows credentials to connect to the Windows generated VMs using WINRM.  The terraform WINRM interfaces uses clear-text passwords for authentication.  The path to a private ssh key allows the terraform installation of the Puppet Master, Jenkins, and Puppet Agent installation.

'''console
vsphere_user_name = "viuser@domain.local"
vsphere_password  = "Password!23"
vsphere_server    = "vcsa.lab.internal"
vsphere_sshkey    = "~/.ssh/lab_id_rsa"

windows_user_name = "winadminuser"
windows_password  = "Password123"
'''

This section describes the site variables used to define the overall configuration for the demonstration environment.  The configuration details are placed in the file **var.tf**.  The specification includes the details of target vmware environment needed to lay-down the VMs for the demonstration enivornment.

```console
variable datacenter      { default = "Datacenter" }
variable cluster         { default = "Cluster" }
variable hosts           { default = [ "labvesx01.fr.lan", "labvesx02.fr.lan"] }
variable network0_switch { default = "vSwitch0" }
variable network0        { default = "VM Network"}
variable datastore0      { default = "vdslabnasnfs01" }
variable dns_servers     { default = [ "10.1.3.1", "10.1.1.1"] }
variable dns_suffixes    { default = [ "fr.lan"] }
variable time_zone       { default = "MST7MDT" }
```

This section defines the Puppet Master configuration environment.  The Puppet Environment builds a monolithic master using a series of Puppet Enterprise features.  The puppet_master bootstrap script configures code manager against an assigned puppet code repository.

As the greenfield VMs install their agent and connect to the Puppet Master, the code repository provides the baseline configuration policy.  Classification of the client VMs uses both the PE external node classifier, and the **site.pp**.  All VMs integrate trusted facts, pp_role, pp_application, and pp_environment, to instantiate an inital environment.  The dynamic classification allows changes to the greenfield VMs at time of installation.

Additionally, the Puppet Master bootstrap configures hiera eyaml for encryption of data.  During demonstration eyaml allows accounts to be created on target VMs without using cleartext passwords.  Prior to starting the enviroment execution, you must create the keys needs.  After gem installation on your local workstation, "gem install hiera-eyaml", the encryption certificates used for hiera must be created using the follow "eyaml createkeys".

This section describes the resources allocated to Jenkins server and client VMs. Depending on the deployment type, you may need to increase the resources to support the quantity of OSs.  The hostname and domain are needed values for each VM.  The name becomes the FQDN becomes the register system name within vCenter.

```console
variable jenkins_name     { default = "labjenkins" }
variable jenkins_domain   { default = "fr.lan" }

variable linux_name     { default = "lablinux" }
variable linux_domain   { default = "fr.lan" }

variable windows_name    { default = "labwindows" }
variable windows_domain  { default = "fr.lan" }
```

## Execution

To build the environment requires you to perform a set of terraform commands.  Terraform downloads the needed providers and begins the build on the environment.  Terraform recently released a new vmware provider with signficant changes.  I attempted to convert the code, but run into a bug.

To initiate the start of the environmet use the following commands in "../vmware":

'''console
terraform init
terraform get
terraform plan
terraform apply
'''