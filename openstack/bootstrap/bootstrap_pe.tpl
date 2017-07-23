#!/bin/bash
set -ex
hostname $(curl http://169.254.169.254/latest/meta-data/local-hostname)
echo $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4) $(hostname) >> /etc/hosts
echo $gitlab_floating_ip gitlab.inf.puppet.vm >> /etc/hosts
mkdir -p /etc/puppetlabs/puppet
echo '*' > /etc/puppetlabs/puppet/autosign.conf
retrycurl() { set +e; while :; do curl "$@"; [ "$?" = 0 ] && break; done; set -e; }
retrycurl --max-time 30 -o pe.archive $pe_source_url
retrycurl --max-time 15 -o pe-demo.tar.gz $pe_demo_build_url
tar -xf pe.archive
mkdir pe-demo && tar -xzf pe-demo.tar.gz -C pe-demo --strip-components 1
cat > pe.conf <<-EOF
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
./pe-demo/scripts/provisioners/puppet_master_bootstrap.sh
