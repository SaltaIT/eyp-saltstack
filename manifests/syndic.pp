class saltstack::syndic(
                      $manage_package           = true,
                      $package_ensure           = 'installed',
                      $manage_service           = true,
                      $manage_docker_service    = true,
                      $service_ensure           = 'running',
                      $service_enable           = true,
                    ) inherits saltstack::params {


  class { 'saltstack::syndic::install': } ->
  class { 'saltstack::syndic::service': } ->
  Class['saltstack::syndic']
}
