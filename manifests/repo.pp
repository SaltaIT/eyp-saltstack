class saltstack::repo($srcdir = '/usr/local/src') inherits saltstack::params {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  #TODO:
  # ubuntu: https://repo.saltstack.com/#ubuntu
  case $::osfamily
  {
    'redhat':
    {
      exec { 'which wget eyp-saltstack':
        command => 'which wget',
        unless  => 'which wget',
      }

      exec { "mkdir p eyp-saltstack ${srcdir}":
        command => "mkdir -p ${srcdir}",
        creates => $srcdir,
      }

      download { 'wget saltstack repo':
        url     => $saltstack::params::saltstack_repo_url,
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
    'Debian':
    {
      apt::key { 'SALTSTACK-GPG-KEY':
        key        => $saltstack::params::saltstack_repo_url_key,
        key_source => $saltstack::params::saltstack_repo_url_key_source,
      }

      # deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main
      apt::source { 'saltstack':
        location => $saltstack::params::saltstack_repo_url,
        release  => $::lsbdistcodename,
        repos    => 'main',
        require  => Apt::Key['SALTSTACK-GPG-KEY'],
      }
    }
    default:
    {
      fail('unsupported')
    }
  }
}
