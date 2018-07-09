define saltstack::master::pillar(
                                    $files       = [],
                                    $environment = $name,
                                  ) {
  if(!defined(Concat::Fragment['pillars base']))
  {
    concat::fragment{ 'pillars base':
      target  => '/etc/salt/master',
      order   => '60',
      content => template("${module_name}/master/pillars/base.erb"),
    }
  }

  concat::fragment{ "pillars environment ${environment}":
    target  => '/etc/salt/master',
    order   => "60-${environment}",
    content => template("${module_name}/master/pillars/files.erb"),
  }

}
