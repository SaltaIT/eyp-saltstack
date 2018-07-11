class saltstack::syndic::install inherits saltstack::syndic {

  case $saltstack::syndic::package_ensure
  {
    'installed': { $pip_ensure='present' }
    'present': { $pip_ensure='present' }
    default: { $pip_ensure='absent' }
  }

  if($saltstack::syndic::manage_package)
  {
    include ::saltstack::repo

    Class['::saltstack::repo'] ->
    package { $saltstack::params::syndic_package_name:
      ensure => $saltstack::syndic::package_ensure,
    }
  }
}
