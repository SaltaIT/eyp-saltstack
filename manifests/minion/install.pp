class saltstack::minion::install inherits saltstack::minion {

  if($saltstack::minion::manage_package)
  {
    include ::saltstack::repo

    package { $saltstack::params::minion_package_name:
      ensure => $saltstack::package_ensure,
    }
  }

}
