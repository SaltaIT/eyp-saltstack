class saltstack::cloud::install inherits saltstack::cloud {

  if($saltstack::cloud::manage_package)
  {
    include saltstack::repo

    Class['saltstack::repo'] ->
    package { $saltstack::params::cloud_package_name:
      ensure => $saltstack::cloud::package_ensure,
    }
  }

  if($saltstack::cloud::install_vsphere_dependencies)
  {
    include python

    pythonpip { 'pyvmomi':
      ensure => 'present',
    }
  }

  if($saltstack::cloud::install_windows_dependencies)
  {
    if($saltstack::params::windows_dependencies!=undef)
    {
      include python

      package { $saltstack::params::windows_dependencies:
        ensure => $saltstack::cloud::package_ensure,
      }
    }
  }
}
