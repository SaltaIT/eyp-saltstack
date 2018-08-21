class { 'saltstack::repo':
  version => '2017.7',
}

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

class { 'saltstack::cloud':
  install_windows_dependencies => false,
}

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
