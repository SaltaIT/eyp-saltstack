class saltstack::ssh::config inherits saltstack::ssh {

  file { '/etc/salt/master.d/salt-ssh.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template("${module_name}/ssh/ssh.erb"),
  }

  file { '/etc/salt/roster':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template("${module_name}/ssh/roster.erb"),
  }
}
