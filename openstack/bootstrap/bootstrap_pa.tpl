#!/bin/bash
#--------------------------------------------------------------
# This scripts bootstraps a linux node with  an installation
# of Puppet Enterprise.
#--------------------------------------------------------------
set -x

#--------------------------------------------------------------
# Global Variables:
#   - PATH:       PATHs needed for command execution
#   - HOME:       Home Directory of script account
#   - PEINSTALL:  Command to install PE agent
#   - WORKDIR:    TMP directory for script
#   - LOGFILE:    Execution Log for bootstrap on client hosts
#--------------------------------------------------------------
PATH=$PATH:/opt/puppetlabs/bin
HOME=/root
PEINSTALL=/tmp/pe_install.sh
WORKDIR="/tmp"
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
  echo ${linux_fqdn} > /etc/hostname
  hostname -F /etc/hostname
  echo ${linux_ip} ${linux_name} ${linux_fqdn}  >> /etc/hosts
	echo ${master_ip} ${master_name} ${master_fqdn}  >> /etc/hosts
}

#--------------------------------------------------------------
# Peform pre-agent installation tasks.
#--------------------------------------------------------------
function pre_install_pa {
  echo "======================= Executing pre_install_pa ======================="
}

#--------------------------------------------------------------
# Peform post-agent installation tasks.
#--------------------------------------------------------------
function post_install_pa {
  echo "=======================" Executing pre_install_pa ======================="
}

#--------------------------------------------------------------
# Wait until PE console is fully operation and install PE
# agent.
#--------------------------------------------------------------
function install_pa {
  echo "=======================" Executing install_pa ======================="

  INTERVAL=1080   # Set interval (duration) in seconds.
  SECONDS=0   # Reset $SECONDS; counting of seconds will (re)start from 0(-ish).

  cd /tmp

  while (( $SECONDS < $INTERVAL )); do    # Loop until interval has elapsed.
    curl -k https://${master_fqdn}:8140/packages/current/install.bash -o "$${PEINSTALL}" && break
    sleep 30
  done
  chmod +x "$${PEINSTALL}"
  "$${PEINSTALL}"
}

#--------------------------------------------------------------
# Initiate Puppet Run.
#--------------------------------------------------------------
function run_puppet {
  echo "======================= Executing install_pa ======================="
  cd /
  puppet agent -t
}

#--------------------------------------------------------------
# Main Script
#--------------------------------------------------------------
setup_host_name
pre_install_pa
install_pa
post_install_pa
run_puppet
exit 0
