class saltstack::minion (
                          $master                = 'saltmaster',
                          $manage_package        = true,
                          $package_ensure        = 'installed',
                          $manage_service        = true,
                          $manage_docker_service = true,
                          $service_ensure        = 'running',
                          $service_enable        = true,
                        ) inherits saltstack::params{

  class { '::saltstack::minion::install': } ->
  class { '::saltstack::minion::config': } ~>
  class { '::saltstack::minion::service': } ->
  Class['::saltstack::minion']

}
