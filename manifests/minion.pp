class saltstack::minion (
                          $master                = 'saltmaster',
                          $master_type           = 'failover',
                          $master_failback       = false,
                          $random_master         = false,
                          $master_port           = '4506',
                          $manage_package        = true,
                          $package_ensure        = 'installed',
                          $manage_service        = true,
                          $manage_docker_service = true,
                          $service_ensure        = 'running',
                          $service_enable        = true,
                          $manage_config         = true,
                          $minion_id             = $::fqdn,
                          $hash_type             = 'sha256',
                        ) inherits saltstack::params{

  # master_type Can be str, failover, func or disable.

  class { '::saltstack::minion::install': } ->
  class { '::saltstack::minion::config': } ~>
  class { '::saltstack::minion::service': } ->
  Class['::saltstack::minion']

}
