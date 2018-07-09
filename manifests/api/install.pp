class saltstack::api::install inherits saltstak::api {

    if($saltstack::api::manage_package)
    {
      include ::saltstack::repo

      Class['::saltstack::repo'] ->
      package { $saltstack::params::api_package_name:
        ensure => $saltstack::api::package_ensure,
      }
    }

}
