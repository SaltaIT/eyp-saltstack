class saltstack::cloud::install inherits saltstack::cloud {

    if($saltstack::cloud::manage_package)
    {
      include ::saltstack::repo

      Class['::saltstack::repo'] ->
      package { $saltstack::params::cloud_package_name:
        ensure => $saltstack::cloud::package_ensure,
      }
    }

    if($saltstack::cloud::install_impacket)
    {
      
    }

    if($saltstack::cloud::install_winrm)
    {

    }

}
