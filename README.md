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

saltstack configuration management

## Module Description

If applicable, this section should have a brief description of the technology
the module integrates with and what that integration enables. This section
should answer the questions: "What does this module *do*?" and "Why would I use
it?"

If your module has a range of functionality (installation, configuration,
management, etc.) this is the time to mention it.

## Setup

### What saltstack affects

* Installs saltstack repo
* Installs saltstack packages and dependencies
* Manages configuration files
* Manages services

### Setup Requirements

This module requires pluginsync enabled for puppet <=3.8

### Beginning with saltstack

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

class { 'saltstack::ssh': }

class { 'saltstack::cloud': }

class { 'saltstack::api': }

class { 'saltstack::syndic': }
```

## Usage

salt minion:

```puppet
class { 'saltstack::minion':
  master => 'salt-master.systemadmin.es'
}
```

salt master:

```puppet
class { 'saltstack::master': }
```

## Reference

TODO

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
