# puppet-control-repo

## Table of Contents

1. [Building an Ephemeral Puppet Demo Environment](#building-a-learning-environent)

## Building a Learning Puppet Environment
This project began as a plan to build a small environment for learning different facets of Puppet Enterprise.  The Repository allows you to spin up a monolithic Puppet Enterprise Console, and a series of agents quickly by combing a terraform environment with Puppet Agent Roles.  The terraform plans support an Openstack environment with some expected predefined environments.

## Install Code Manager
Code Manager requires you to configure both the PE console to define the Code Manager repository, and setup the client tools on your MAC.  Puppet documentation takes care of walking you through the steps:

Bootstrapping the Puppet Master must included enabling the repositories for various OS agents.  The PM bootstraps builds node classification for the master, linux, and windows base roles.  PM class requires the code manager repository add the classes to support the agent installation.  Review the role.pp, https://github.com/cdrobey/puppet-repo/blob/production/site/role/manifests/master.pp, for better explanation.

Code Manager Setup:  https://docs.puppet.com/pe/latest/cmgmt_managing_code.html

Commands:
puppet-access login --service-url https://puppet:4433/rbac-api --lifetime 180d
puppet-code deploy production --wait


Github (Example Repository): https://github.com/puppetlabs/control-repo

@cdrobey
