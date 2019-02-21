class { 'saltstack::repo':
  version       => '2018.3',
  version_minor => '2',
}

class { 'saltstack::minion':
  master => '127.0.0.1'
}

saltstack::minion::grain { 'demo1':
  value => 'demo-text',
}

saltstack::minion::grain { 'demo2':
  value => [ 'array', 'data' ],
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
