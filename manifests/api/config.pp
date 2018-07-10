class saltstack::api::config inherits saltstack::api {

  if($saltstack::api::generate_selfsigned_cert)
  {
    exec { 'selfsigned cert API':
      command => 'salt-call --local tls.create_self_signed_cert',
      path    => '/usr/sbin:/usr/bin:/sbin:/bin',
      creates => '/etc/pki/tls/certs/localhost.crt',
      before  => File['/etc/salt/master.d/salt-api.conf'],
    }
  }

  file { '/etc/salt/master.d/salt-api.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => template("${module_name}/api/api.erb"),
  }

}
