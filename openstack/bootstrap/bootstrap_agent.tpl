#!/bin/bash
#
# Template parameters
#   - $master_ip
#
MASTER_NAME=${master_name}
MASTER_FQDN=${master_fqdn}
MASTER_IP=${master_ip}

echo $${MASTER_IP} $${MASTER_NAME} $${MASTER_FQDN}  >> /etc/hosts
hostname $(curl http://169.254.169.254/latest/meta-data/local-hostname)
echo $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4) $(hostname) >> /etc/hosts
curl -k https://$${MASTER_FQDN}:8140/packages/current/install.bash | bash
