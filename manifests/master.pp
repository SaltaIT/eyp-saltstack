class saltstack::master (
                          $interface             = '0.0.0.0',
                          $ipv6                  = false,
                          $user                  = 'root',
                          $publish_port          = '4505',
                          $ret_port              = '4506',
                          $manage_package        = true,
                          $package_ensure        = 'installed',
                          $manage_service        = true,
                          $manage_docker_service = true,
                          $service_ensure        = 'running',
                          $service_enable        = true,
                        ) inherits saltstack::params{

  class { '::saltstack::master::install': } ->
  class { '::saltstack::master::config': } ~>
  class { '::saltstack::master::service': } ->
  Class['::saltstack::master']

}
