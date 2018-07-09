class { 'saltstack::minion': }

class { 'saltstack::master': }

saltstack::master::pillar { 'base':
  files => [ '/srv/salt-data/pillar' ],
}

saltstack::master::fileroot { 'base':
  files => [ '/srv/salt-data/pillar' ],
}

class { 'saltstack::cloud': }

class { 'saltstack::api': }
