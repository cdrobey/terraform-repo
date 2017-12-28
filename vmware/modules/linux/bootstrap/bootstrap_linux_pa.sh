#!/bin/bash
#--------------------------------------------------------------
# This scripts bootstraps a linux node by installing a puppet
# agent.
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
HOME=/tmp
PEINSTALL=/tmp/pe_install.sh
PEINSTALL_URL="https://labpuppet:8140/packages/current/install.bash"
WORKDIR="/tmp"
LOGFILE="${WORKDIR}/bootstrap$$$$.log"

#--------------------------------------------------------------
# Redirect all stdout and stderr to logfile,
#--------------------------------------------------------------
echo "======================= Executing setup_logging ======================="
cd "${WORKDIR}" || exit 1
exec > "${LOGFILE}" 2>&1

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
  echo "======================= Executing pre_install_pa ======================="
}

#--------------------------------------------------------------
# Wait until PE console is fully operation and install PE
# agent.
#--------------------------------------------------------------
function install_pa {
  echo "======================= Executing install_pa ======================="

  INTERVAL=1800   # Set interval (duration) in seconds.
  SECONDS=0   # Reset $SECONDS; counting of seconds will (re)start from 0(-ish).

  cd /tmp || exit 1

  while (( SECONDS < INTERVAL )); do    # Loop until interval has elapsed.
    curl -k ${PEINSTALL_URL} -o "${PEINSTALL}" && break
    sleep 30
  done
  chmod +x "${PEINSTALL}"
  "${PEINSTALL}"
}

#--------------------------------------------------------------
# Initiate Puppet Run.
#--------------------------------------------------------------
function run_puppet {
  echo "======================= Executing install_pa ======================="
  cd / || exit 1
  puppet agent -t
}

#--------------------------------------------------------------
# Main Script
#--------------------------------------------------------------
pre_install_pa
install_pa
post_install_pa
run_puppet