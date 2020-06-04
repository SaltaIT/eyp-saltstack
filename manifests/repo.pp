class saltstack::repo (
                        $srcdir        = '/usr/local/src',
                        $version       = 'latest',
                        $version_minor = undef,
                        $protocol      = 'https',
                      ) inherits saltstack::params {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if($saltstack::params::saltstack_repo_url[$version]==undef)
  {
    fail("unsupported version: ${version}")
  }

  #TODO:
  # ubuntu: https://repo.saltstack.com/#ubuntu
  case $::osfamily
  {
    'redhat':
    {
      if($version_minor!=undef)
      {
        # https://docs.saltstack.com/en/latest/topics/installation/rhel.html
        #
        # [saltstack-repo]
        # name=SaltStack repo for Red Hat Enterprise Linux $releasever
        # baseurl=https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest
        # enabled=1
        # gpgcheck=1
        # gpgkey=https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest/SALTSTACK-GPG-KEY.pub
        #        https://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest/base/RPM-GPG-KEY-CentOS-7

        yumrepo { 'saltstack-repo':
          baseurl  => "${protocol}://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/archive/${version}.${version_minor}",
          descr    => "SaltStack repo for Red Hat Enterprise Linux - ${version}.${version_minor}",
          enabled  => '1',
          gpgcheck => '1',
          gpgkey   => "${protocol}://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest/SALTSTACK-GPG-KEY.pub ${protocol}://repo.saltstack.com/yum/redhat/$releasever/$basearch/latest/base/RPM-GPG-KEY-CentOS-7",
        }
      }
      else
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
          url     => "${protocol}${saltstack::params::saltstack_repo_url[$version]}",
          creates => "${srcdir}/saltstack_repo.${saltstack::params::package_provider}",
          require => Exec[ "mkdir p eyp-saltstack ${srcdir}", 'which wget eyp-saltstack' ],
        }

        package { $saltstack::params::saltstack_repo_name:
          ensure   => 'installed',
          provider => $saltstack::params::package_provider,
          source   => "${srcdir}/saltstack_repo.${saltstack::params::package_provider}",
          require  => Download['wget saltstack repo'],
        }
      }
    }
    'Debian':
    {
      if($version_minor!=undef)
      {
        fail('version_minor is unsupported on this OS')
      }

      apt::key { 'SALTSTACK-GPG-KEY':
        key        => $saltstack::params::saltstack_repo_url_key,
        key_source => "${protocol}${saltstack::params::saltstack_repo_url_key_source[$version]}",
      }

      # deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main
      apt::source { 'saltstack':
        location => "${protocol}${saltstack::params::saltstack_repo_url[$version]}",
        release  => $::lsbdistcodename,
        repos    => 'main',
        require  => Apt::Key['SALTSTACK-GPG-KEY'],
      }
    }
    'Suse':
    {
      if($version_minor!=undef)
      {
        fail('version_minor is unsupported on this OS')
      }

      # https://repo.saltstack.com/index.html#suse

      exec { 'zypper addrepo':
        command => "zypper addrepo -G ${protocol}${saltstack::params::saltstack_repo_url[$version]}",
        unless  => "zypper lr | grep ${saltstack::params::saltstack_repo_name}",
        notify  => Exec['zypper refresh'],
      }

      exec { 'zypper refresh':
        command     => 'zypper refresh',
        refreshonly => true,
      }

    }
    default:
    {
      fail('unsupported')
    }
  }
}
