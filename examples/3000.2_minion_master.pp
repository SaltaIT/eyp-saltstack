class { 'saltstack::repo':
  version       => '3000',
  version_minor => '2',
}

class { 'saltstack::minion':
  master => '127.0.0.1',
}

class { 'saltstack::master': }

saltstack::master::fileroot { 'base':
  files => [ '/srv/salt-data/base' ],
}

saltstack::master::pillar { 'base':
  files => [ '/srv/salt-data/pillar' ],
}

saltstack::master::key { $facts['networking']['fqdn']:
  status => 'accepted',
}

saltstack::master::acl { 'saltuser':
  match => [ '.*', '@runner' ],
}

saltstack::master::acl { 'saltuser2':
  match => [ '.*', '@runner' ],
}
