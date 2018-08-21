# saltstack

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What saltstack affects](#what-saltstack-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with saltstack](#beginning-with-saltstack)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

saltstack - minion, master, api, cloud, syndic and ssh setup and configuration

## Module Description

This module installs saltstack components:
* minion
* master
* api
* cloud
* syndic
* ssh

Using a yum/apt repo as appropriate

## Setup

### What saltstack affects

* Installs saltstack repo
* Installs saltstack packages and dependencies
* Manages configuration files
* Manages services

### Setup Requirements

This module requires pluginsync enabled for puppet <=3.8

### Beginning with saltstack

A single node configuration example with ACLs:

```puppet
class { 'saltstack::minion':
  master => '127.0.0.1'
}

class { 'saltstack::master': }

saltstack::master::fileroot { 'base':
  files => [ '/srv/salt-data/base' ],
}

saltstack::master::pillar { 'base':
  files => [ '/srv/salt-data/pillar' ],
}

class { 'saltstack::cloud': }

class { 'saltstack::api': }

class { 'saltstack::syndic': }

saltstack::master::key { $::fqdn:
  status => 'accepted'
}

saltstack::master::acl { 'saltuser':
  match => [ '.*', '@runner' ],
}

saltstack::master::acl { 'saltuser2':
  match => [ '.*', '@runner' ],
}
```

## Usage

Installing a salt minion:

```puppet
class { 'saltstack::minion':
  master => 'salt-master.systemadmin.es'
}
```

Installing a salt master:

```puppet
class { 'saltstack::master': }
```

## Reference

### references

#### saltstack::master::key

**WARNING**: keys are not going to be accepted/rejected in the first run if saltstak is not yet installed

* **hostname**: = $name,
* **status**:   = 'accepted',

### classes

#### saltstack

Placeholder, not needed

#### saltstack::repo

saltstack repo installation

* **srcdir**: Where to store temporal files (default: /usr/local/src)
* **version**: saltstack version to install, does not update to the latest once it is already installed (default: latest)

#### saltstack::minion

* **master**:  'saltmaster',
* **master_type**:           = 'failover',
* **master_failback**:       = false,
* **random_master**:         = false,
* **master_port**:           = '4506',
* **manage_package**:        = true,
* **package_ensure**:        = 'installed',
* **manage_service**:        = true,
* **manage_docker_service**: = true,
* **service_ensure**:        = 'running',
* **service_enable**:        = true,
* **minion_id**:             = $::fqdn,
* **hash_type**:             = 'sha256',

#### saltstack::master

* **manage_package**:        = true,
* **package_ensure**:        = 'installed',
* **manage_service**:        = true,
* **manage_docker_service**: = true,
* **service_ensure**:        = 'running',
* **service_enable**:        = true,
* **interface**:             = '0.0.0.0',
* **ipv6**:                  = false,
* **user**:                  = 'root',
* **publish_port**:          = '4505',
* **ret_port**:              = '4506',
* **keep_jobs**:             = '170',
* **max_event_size**:        = '10485760',
* **hash_type**:             = 'sha256',
* **masted_recurse**:        = true,
* **masted_purge**:          = true,

#### saltstack::api

* **manage_package**:           = true,
* **package_ensure**:           = 'installed',
* **manage_service**:           = true,
* **manage_docker_service**:    = true,
* **service_ensure**:           = 'running',
* **service_enable**:           = true,
* **port**:                     = '8000',
* **host**:                     = undef,
* **debug**:                    = false,
* **ssl_crt**:                  = undef,
* **ssl_key**:                  = undef,
* **disable_ssl**:              = undef,
* **webhook_disable_auth**:     = false,
* **webhook_url**:              = undef,
* **thread_pool**:              = '100',
* **socket_queue_size**:        = '30',
* **expire_responses**:         = false,
* **max_request_body_size**:    = '1048576',
* **collect_stats**:            = false,
* **static**:                   = undef,
* **static_path**:              = undef,
* **app**:                      = undef,
* **app_path**:                 = undef,
* **root_prefix**:              = '/',
* **generate_selfsigned_cert**: = true,
* **rest_timeout**:             = '7200',

#### saltstack::cloud

* **manage_package**:               = true,
* **package_ensure**:               = 'installed',
* **keysize**:                      = '2048',
* **script**:                       = undef,
* **log_file**:                     = '/var/log/salt/cloud',
* **log_level**:                    = 'info',
* **log_level_logfile**:            = 'info',
* **log_datefmt**:                  = '%Y-%m-%d %H:%M:%S',
* **log_fmt_logfile**:              = undef,
* **log_granular_levels**:          = undef,
* **delete_sshkeys**:               = false,
* **install_windows_dependencies**: = true,
* **install_vsphere_dependencies**: = true,

#### saltstack::ssh

* **manage_package**:        = true,
* **package_ensure**:        = 'installed',

#### saltstack::syndic

* **manage_package**:           = true,
* **package_ensure**:           = 'installed',
* **manage_service**:           = true,
* **manage_docker_service**:    = true,
* **service_ensure**:           = 'running',
* **service_enable**:           = true,

## Limitations

### salt-minion

* RedHat 6 and derivatives
* RedHat 7 and derivatives
* Ubuntu 14.04
* Ubuntu 16.04
* Ubuntu 18.04

### server components

* RedHat 7 and derivatives
* Ubuntu 16.04
* Ubuntu 18.04

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
