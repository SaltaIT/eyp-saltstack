class saltstack::master::install inherits saltstack::master {

  if($saltstack::master::manage_package)
  {
    include ::saltstack::repo

    package { $saltstack::params::master_package_name:
      ensure => $saltstack::master::package_ensure,
    }
  }
}
