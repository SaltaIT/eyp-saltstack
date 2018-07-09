class saltstack::cloud::install inherits saltstak::cloud {

    if($saltstack::cloud::manage_package)
    {
      include ::saltstack::repo

      Class['::saltstack::repo'] ->
      package { $saltstack::params::cloud_package_name:
        ensure => $saltstack::cloud::package_ensure,
      }
    }

}
