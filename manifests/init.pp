# == Class: saltstack
#
# === saltstack documentation
#
class saltstack(
                            $manage_package        = true,
                            $package_ensure        = 'installed',
                            $manage_service        = true,
                            $manage_docker_service = true,
                            $service_ensure        = 'running',
                            $service_enable        = true,
                          ) inherits saltstack::params{

  class { '::saltstack::install': } ->
  class { '::saltstack::config': } ~>
  class { '::saltstack::service': } ->
  Class['::saltstack']

}
