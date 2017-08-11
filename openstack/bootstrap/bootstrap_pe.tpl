#!/bin/bash
#--------------------------------------------------------------
# This scripts bootstraps a linux node by installing a puppet
# master.
#--------------------------------------------------------------
set -x

#--------------------------------------------------------------
# Global Variables:
#   - PATH:       PATHs needed for command execution
#   - HOME:       Home Directory of script account
#   - WORKDIR:    TMP directory for script
#   - LOGFILE:    Execution Log for bootstrap on client hosts
#--------------------------------------------------------------
PATH=$PATH:/opt/puppetlabs/bin
HOME=/root
WORKDIR="/root"
LOGFILE="$${WORKDIR}/bootstrap$$$$.log"

#--------------------------------------------------------------
# Redirect all stdout and stderr to logfile,
#--------------------------------------------------------------
echo "======================= Executing setup_logging ======================="
cd "$${WORKDIR}"
exec > "$${LOGFILE}" 2>&1

#--------------------------------------------------------------
# Configure hostname and setup host file.
#--------------------------------------------------------------
function setup_host_name {
  echo "======================= Executing setup_host_name ======================="
  echo ${master_fqdn} > /etc/hostname
  hostname -F /etc/hostname
	echo ${master_ip} ${master_name} ${master_fqdn}  >> /etc/hosts
}

#--------------------------------------------------------------
# Initiate Puppet Run.
#--------------------------------------------------------------
function run_puppet {
  echo "======================= Executing install_pe ======================="

  cd /
  puppet agent -t
}

#--------------------------------------------------------------
# Peform pre-master installation tasks.
#--------------------------------------------------------------
function pre_install_pe {
  echo "======================= Executing pre_install_pa ======================="

  yum -y install wget pciutils
  wget https://s3.amazonaws.com/pe-builds/released/2017.2.2/puppet-enterprise-2017.2.2-el-7-x86_64.tar.gz
  tar -xzf puppet-enterprise-2017.2.2-el-7-x86_64.tar.gz -C /tmp/
  mkdir -p /etc/puppetlabs/puppet/
  echo "*" > /etc/puppetlabs/puppet/autosign.conf
  cat > /etc/puppetlabs/puppet/csr_attributes.yaml << YAML
extension_requests:
    pp_role:  puppetmaster
YAML

}

#--------------------------------------------------------------
# Peform post-master installation tasks.
#--------------------------------------------------------------
function post_install_pe {
  echo "======================= Executing post_install_pe ======================="

  mkdir -p /etc/puppetlabs/puppetserver/ssh
  echo ${git_pri_key} > /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa
  chmod 400 /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa
  echo ${git_pub_key} > /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa.pub
  chmod 400 /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa.pub

  puppet module install pltraining-rbac
  cat > /tmp/user.pp << FILE
rbac_user { 'deploy':
    ensure       => 'present',
    name         => 'deploy',
    display_name => 'deployment user account',
    email        => 'chris.roberson@puppet.com',
    password     => 'puppetlabs',
    roles        => [ 'Code Deployers' ],
}

FILE
  puppet apply /tmp/user.pp
  rm /tmp/user.pp
  puppet-access -t $${HOME}/.puppetlabs/token login --lifetime=1y << TEXT
deploy
puppetlabs
TEXT

  puppet-code -t $${HOME}/.puppetlabs/token deploy production -w
}

#--------------------------------------------------------------
# Peform master installation tasks.
#--------------------------------------------------------------
function install_pe {
  echo "======================= Executing install_pe ======================="

  cat > /tmp/pe.conf << FILE
"console_admin_password": "puppetlabs"
"puppet_enterprise::puppet_master_host": "%{::trusted.certname}"
"puppet_enterprise::profile::master::code_manager_auto_configure": true
"puppet_enterprise::profile::master::r10k_remote": "${git_url}"
"puppet_enterprise::profile::master::r10k_private_key": "/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa"
"pe_repo::platform::windows_x86_64": "true"
FILE
  /tmp/puppet-enterprise-2017.2.2-el-7-x86_64/puppet-enterprise-installer -c /tmp/pe.conf
  chown pe-puppet:pe-puppet /etc/puppetlabs/puppetserver/ssh/id-*
}

setup_host_name
pre_install_pe
install_pe
post_install_pe
run_puppet

echo "Completed the Bootstrap of Puppet Enterprise!"
