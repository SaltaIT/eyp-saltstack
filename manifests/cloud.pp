class saltstack::cloud(
                        $manage_package               = true,
                        $package_ensure               = 'installed',
                        $keysize                      = '2048',
                        $script                       = undef,
                        $log_file                     = '/var/log/salt/cloud',
                        $log_level                    = 'info',
                        $log_level_logfile            = 'info',
                        $log_datefmt                  = '%Y-%m-%d %H:%M:%S',
                        $log_fmt_logfile              = undef,
                        $log_granular_levels          = undef,
                        $delete_sshkeys               = false,
                        $install_windows_dependencies = true,
                        $install_vsphere_dependencies = true,
                      ) inherits saltstack::params {

  case $facts['os']['family']
  {
    'redhat':
    {
      case $facts['os']['release']['full']
      {
        /^6.*$/: { fail("cloud is not unsupported for this OS - ${facts['os']['family']}/${facts['os']['release']['full']}") }
        /^7.*$/: { }
        default: { }
      }
    }
    'Debian':
    {
      case $facts['os']['name']
      {
        'Ubuntu':
        {
          case $facts['os']['release']['full']
          {
            /^14.*$/: { fail("cloud is not unsupported for this OS - ${facts['os']['family']}/${facts['os']['release']['full']}") }
            /^16.*$/: { }
            /^18.*$/: { }
            default: { }
          }
        }
        default: { }
      }
    }
    default: { }
  }

  include saltstack::master

  Class['saltstack::master'] ->
  class { 'saltstack::cloud::install': } ->
  class { 'saltstack::cloud::config': } ->
  Class['saltstack::cloud']
}
