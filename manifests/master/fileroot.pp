# file_roots:
#   base:
#     - /srv/salt/
#   dev:
#     - /srv/salt/dev/services
#     - /srv/salt/dev/states
#   prod:
#     - /srv/salt/prod/services
#     - /srv/salt/prod/states
define saltstack::master::fileroot(
                                    $files       = [],
                                    $environment = $name,
                                  ) {
  if(!defined(Concat::Fragment['fileroots base']))
  {
    concat::fragment{ 'fileroots base':
      target  => '/etc/salt/master',
      order   => '50',
      content => template("${module_name}/master/fileroots/base.erb"),
    }
  }

  concat::fragment{ "fileroots environment ${environment}":
    target  => '/etc/salt/master',
    order   => "50-${environment}",
    content => template("${module_name}/master/fileroots/files.erb"),
  }

}
