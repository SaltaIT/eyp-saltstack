class saltstack::ssh::install inherits saltstack::ssh {

    if($saltstack::ssh::manage_package)
    {
      include ::saltstack::repo

      Class['::saltstack::repo'] ->
      package { $saltstack::params::ssh_package_name:
        ensure => $saltstack::ssh::package_ensure,
      }
    }

}
