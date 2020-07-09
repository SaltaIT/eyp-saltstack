class saltstack::repo (
                        $srcdir        = '/usr/local/src',
                        $version       = 'latest',
                        $version_minor = undef,
                        $protocol      = 'https',
                      ) inherits saltstack::params {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  #TODO:
  # ubuntu: https://repo.saltstack.com/#ubuntu
  case $facts['os']['family']
  {
    'redhat':
    {
      if($version_minor!=undef)
      {
        $composite_version = "archive/${version}.${version_minor}"
      }
      else
      {
        $composite_version = $version
      }
      # [saltstack-repo]
      # name=SaltStack repo for RHEL/CentOS 7
      # baseurl=https://repo.saltstack.com/yum/redhat/7/$basearch/archive/3000.3
      # enabled=1
      # gpgcheck=1
      # gpgkey=https://repo.saltstack.com/yum/redhat/7/$basearch/archive/3000.3/SALTSTACK-GPG-KEY.pub

      if ($version == 'latest')
      {
        $base_yum_repo = 'py3'
      }
      elsif versioncmp($version, '3000') > 0
      {
        $base_yum_repo = 'py3'
      }
      else
      {
        $base_yum_repo = $saltstack::params::base_repo
      }

      yumrepo { 'saltstack-repo':
        baseurl  => "${protocol}://repo.saltstack.com/${base_yum_repo}/redhat/\$releasever/\$basearch/${composite_version}",
        descr    => "SaltStack repo - ${version} ${version_minor}",
        enabled  => '1',
        gpgcheck => '1',
        gpgkey   => "${protocol}://repo.saltstack.com/yum/redhat/\$releasever/\$basearch/${composite_version}/SALTSTACK-GPG-KEY.pub",
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
    default:
    {
      fail('unsupported')
    }
  }
}
