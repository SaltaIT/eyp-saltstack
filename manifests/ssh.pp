class saltstack::ssh(
                        $manage_package        = true,
                        $package_ensure        = 'installed',
                      ) inherits saltstack::params {

  include saltstack::master

  Class['saltstack::master'] ->
  class { 'saltstack::ssh::install': } ->
  class { 'saltstack::ssh::config': } ->
  Class['saltstack::ssh']
}
