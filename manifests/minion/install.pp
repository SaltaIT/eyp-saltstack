class saltstack::minion::install inherits saltstack::minion {

  include ::saltstack::repo

  if($saltstack::minion::manage_package)
  {
    package { $saltstack::params::minion_package_name:
      ensure => $saltstack::package_ensure,
    }
  }
}
