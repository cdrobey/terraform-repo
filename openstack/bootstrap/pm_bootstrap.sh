#!/bin/bash

# this script deploys using the tar.gz found in the code folder
#
# If there is no such file, then it writes a message to this effect to stdout.
# It then drops any firewall rules on the master vagrant box (this is
# typically handled by the seteam demo code).
#
# (This results in a stock PE environment with no demo code or modules.)

PATH="/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin:/opt/puppet/bin:$PATH"
PMDOWNLOAD="http://pe-releases.puppetlabs.net/2017.2.1/puppet-enterprise-2017.2.1-el-7-x86_64.tar.gz"


##############################################################################
# Main execution
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
##############################################################################
main()
{
  prereqs
  install_pe
  setup_codemanager
  setup_hiera
}

##############################################################################
# Install the repos and perform a complete installation from the PE download
# Globals:
#   PWDOWNLOAD
# Arguments:
#   None
# Returns:
#   None
##############################################################################
install_pe()
{
  mkdir -p /etc/puppetlabs/puppet
  echo '*' > /etc/puppetlabs/puppet/autosign.conf

  retrycurl() { set +e; while :; do curl "$@"; [ "$?" = 0 ] && break; done; set -e; }
  retrycurl --max-time 30 -o pe.archive $${PWDOWNLOAD}

  tar -xf pe.archive
  mkdir pe-demo && tar -xzf pe-demo.tar.gz -C pe-demo --strip-components 1
  cat > pe.conf << EOF
  {
    "console_admin_password": "puppetlabs"
    "puppet_enterprise::puppet_master_host": "%{::trusted.certname}"
    "puppet_enterprise::use_application_services": true
    "puppet_enterprise::profile::master::r10k_remote": "/opt/puppetlabs/repos/control-repo.git"
    "puppet_enterprise::profile::master::r10k_private_key": ""
    "puppet_enterprise::profile::master::code_manager_auto_configure": true
    "puppet_enterprise::profile::master::check_for_updates": false
  }
  EOF
  ./puppet-enterprise-*-el-7-x86_64/puppet-enterprise-installer -c pe.conf
}

##############################################################################
# Setup the prereqs for bootstrapping prior to install PE
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
##############################################################################

prereqs()
{
  yum -y install curl
  hostname $(curl http://169.254.169.254/latest/meta-data/local-hostname)
  echo $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4) $(hostname) >> /etc/hosts
}

##############################################################################
# Setup Code Manager Accounts, Keys, and Perform initial Staging
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
##############################################################################
setup_codemanager()
{
  read -r -d '' PRIV_KEY << EOM
    ${ssh_pri_key}
  EOM
  read -r -d '' PUBLIC_KEY << EOM
    ${ssh_pub_key}
  EOM

  cat > /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa << PRIVATE
    $PRIV_KEY
  PRIVATE
  cat > /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa.pub << PUBLIC
    $PUBLIC_KEY
  PUBLIC
  chown pe-puppet:pe-puppet /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa.pub
  chown pe-puppet:pe-puppet /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa

  /opt/puppetlabs/puppet/bin/curl -k -X POST -H 'Content-Type: application/json' \
    https://`facter fqdn`:4433/rbac-api/v1/roles \
    https://`facter fqdn`:4433/rbac-api/v1/roles \
    -d '{"description":"","user_ids":[],"group_ids":[],"display_name":"Node Data Viewer","permissions":[{"object_type":"nodes","action":"view_data","instance":"*"}]}' \
    --cert /`puppet config print ssldir`/certs/`facter fqdn`.pem \
    --key /`puppet config print ssldir`/private_keys/`facter fqdn`.pem \
    --cacert /`puppet config print ssldir`/certs/ca.pem

  /opt/puppetlabs/puppet/bin/curl -k -X POST -H 'Content-Type: application/json' \
    https://`facter fqdn`:4433/rbac-api/v1/users \
    -d '{"login": "deploy", "password": "puppetlabs", "email": "", "display_name": "", "role_ids": [2,5]}' \
    --cert /`puppet config print ssldir`/certs/`facter fqdn`.pem \
    --key /`puppet config print ssldir`/private_keys/`facter fqdn`.pem \
    --cacert /`puppet config print ssldir`/certs/ca.pem

  /opt/puppetlabs/bin/puppet-access login deploy --lifetime=1y << TEXT
    puppetlabs
  TEXT

  /opt/puppetlabs/bin/puppet-code deploy production -w
}

##############################################################################
# Setup Hiera to support encrypted yaml
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   None
##############################################################################
setup_hiera()
{
  /opt/puppetlabs/bin/puppetserver gem install hiera-eyaml
  /opt/puppetlabs/puppet/bin/gem install hiera-eyaml
  /opt/puppetlabs/bin/puppet apply -e "include profile::puppet::hiera"
}

main
