#!/bin/bash

HOST_NAME=${name}
HOST_FQDN=${name}.{location}.lab
MASTER_NAME=${master_name}
MASTER_FQDN=${master_name}.${master_location}.lab
MASTER_IP=${master_ip}

function setup_networking {
  echo "127.0.0.1 $HOST_NAME $HOST_FQDN localhost.localdomain localhost" > /etc/hosts
  echo "$MASTER_IP $MASTER_NAME $MASTER_FQDN" >> /etc/hosts
}

function install_prereqs {
  yum -y install curl
}

function install_pe_puppetagent {
  mkdir -p /etc/puppetlabs/puppet
  echo '[agent]' >> /etc/puppetlabs/puppet/puppet.conf
  echo "server = $HOST_FQDN" >> /etc/puppetlabs/puppet/puppet.conf
  cat > /etc/puppetlabs/puppet/csr_attributes.yaml << YAML
extension_requests:
    pp_role:  ${role}
YAML
  curl -k https://$HOST_FQDN:8140/packages/current/install.bash | bash
  service puppet start
}

setup_networking
install_prereqs
install_pe_puppetagent
