class saltstack::api::install inherits saltstack::api {

    if($saltstack::api::manage_package)
    {
      include ::saltstack::repo

      Class['::saltstack::repo'] ->
      package { $saltstack::params::api_package_name:
        ensure => $saltstack::api::package_ensure,
      }

      if($saltstack::params::api_dependencies!=undef)
      {
        package { $saltstack::params::api_dependencies:
          ensure => $saltstack::api::package_ensure,
          before => Package[$saltstack::params::api_package_name],
        }
      }

      if($saltstack::params::api_pip_dependencies!=undef)
      {
        pythonpip { $saltstack::params::api_pip_dependencies:
          ensure => $saltstack::api::package_ensure,
          before => Package[$saltstack::params::api_package_name],
        }
      }
    }

}
