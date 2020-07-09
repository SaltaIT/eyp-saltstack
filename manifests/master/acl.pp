define saltstack::master::acl (
                                $user        = $name,
                                $backend     = 'pam',
                                $match       = '.*',
                              ) {
  include saltstack::master

  if(!defined(Concat['/etc/salt/master.d/external_auth.conf']))
  {
    concat { '/etc/salt/master.d/external_auth.conf':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      require => File['/etc/salt/master.d'],
    }

    concat::fragment { 'salt master external_auth header':
      target  => '/etc/salt/master.d/external_auth.conf',
      order   => '00',
      content => "# puppet managed file\nexternal_auth:\n",
    }
  }

  if(!defined(Concat::Fragment["salt master external_auth backend ${backend}"]))
  {
    concat::fragment { "salt master external_auth backend ${backend}":
      target  => '/etc/salt/master.d/external_auth.conf',
      order   => "01-${backend}",
      content => "  ${backend}:\n",
    }
  }

  concat::fragment { "salt master external_auth user ${user}":
    target  => '/etc/salt/master.d/external_auth.conf',
    order   => "01-${backend}-${user}",
    content => template("${module_name}/master/acl.erb"),
  }
}
