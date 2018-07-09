class saltstak::api::config inherits saltstak::api {

  file { '/etc/salt/master.d/salt-api.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template("${module_name}/api/api.erb"),
  }
}
