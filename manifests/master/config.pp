class saltstack::master::config inherits saltstack::master {

  file { '/etc/salt/master.d':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => $saltstack::master::masted_recurse,
    purge   => $saltstack::master::masted_purge,
  }

  concat { '/etc/salt/master':
    ensure => 'present',
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
  }

  concat::fragment{ 'salt master base config':
    target  => '/etc/salt/master',
    content => template("${module_name}/master/master.erb"),
    order   => '00',
  }
}
