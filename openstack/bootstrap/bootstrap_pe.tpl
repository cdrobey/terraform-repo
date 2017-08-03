#!/bin/bash
set -x

# PATH FOR Puppet Executables
PATH=$PATH:/opt/puppetlabs/bin

# Use root's home directory for launch
WORKDIR="/root"
cd "$${WORKDIR}"

# Redirect all stdout and stderr to logfile
LOGFILE="$${WORKDIR}/bootstrap$$$$.log"
exec > "$${LOGFILE}" 2>&1

function setup_networking {
  echo ${master_fqdn} > /etc/hostname
  hostname -F /etc/hostname
	echo ${master_ip} ${master_name} ${master_fqdn}  >> /etc/hosts

}

function copy_ssh_keys {
  mkdir -p /etc/puppetlabs/puppetserver/ssh
  echo ${git_pri_key} > /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa
	chmod 400 /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa
  echo ${git_pub_key} > /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa.pub
	chmod 400 /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa.pub
}


function setup_hiera_pe {
  sleep 15
  puppet apply -e "include profile::puppet::hiera"
  puppetserver gem install hiera-eyaml
}

function run_puppet {
  cd /
  puppet agent -t
}

function download_pe {
  yum -y install wget pciutils
  wget https://s3.amazonaws.com/pe-builds/released/2017.2.2/puppet-enterprise-2017.2.2-el-7-x86_64.tar.gz
  tar -xzf puppet-enterprise-2017.2.2-el-7-x86_64.tar.gz -C /tmp/
}

function install_pe {
  mkdir -p /etc/puppetlabs/puppet
  cat > /etc/puppetlabs/puppet/csr_attributes.yaml << YAML
extension_requests:
    pp_role:  puppetmaster
YAML

  cat > /tmp/pe.conf << FILE
"console_admin_password": "puppetlabs"
"puppet_enterprise::puppet_master_host": "%{::trusted.certname}"
"puppet_enterprise::profile::master::code_manager_auto_configure": true
"puppet_enterprise::profile::master::r10k_remote": "${git_url}"
"puppet_enterprise::profile::master::r10k_private_key": "/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa"
FILE
  /tmp/puppet-enterprise-2017.2.2-el-7-x86_64/puppet-enterprise-installer -c /tmp/pe.conf
  chown pe-puppet:pe-puppet /etc/puppetlabs/puppetserver/ssh/id-*
}

function add_pe_users {
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

  puppet-access login --lifetime=1y << TEXT
deploy
puppetlabs
TEXT
}

function deploy_code_pe {
  puppet-code deploy production -w
}

setup_networking
download_pe
copy_ssh_keys
install_pe
add_pe_users
deploy_code_pe
setup_hiera_pe
run_puppet

echo "Completed the Bootstrap of Puppet Enterprise!"
