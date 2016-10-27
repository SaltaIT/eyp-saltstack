class saltstack::repo($srcdir = '/usr/local/src') inherits saltstack::params {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  exec { 'which wget eyp-saltstack':
    command => 'which wget',
    unless  => 'which wget',
  }

  exec { "mkdir p eyp-saltstack ${srcdir}":
    command => "mkdir -p ${srcdir}",
    creates => $srcdir,
  }

  exec { 'wget saltstack repo':
    command => "wget ${saltstack::params::saltstack_repo_url} -O ${srcdir}/saltstack_repo.${saltstack::params::package_provider}",
    creates => "${srcdir}/saltstack_repo.${saltstack::params::package_provider}",
    require => Exec[ "mkdir p eyp-saltstack ${srcdir}", 'which wget eyp-saltstack' ],
  }

  package { $saltstack::params::saltstack_repo_name:
    ensure   => 'installed',
    provider => $saltstack::params::package_provider,
    source   => "${srcdir}/saltstack_repo.${saltstack::params::package_provider}",
    require  => Exec['wget saltstack repo'],
  }

}
