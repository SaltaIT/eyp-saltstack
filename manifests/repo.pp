class saltstack::repo (
                        $srcdir         = '/usr/local/src',
                        $version        = 'latest',
                        $version_minor  = undef,
                        $protocol       = 'https',
                        $python_version = undef,
                      ) inherits saltstack::params {

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }


  if($version_minor!=undef)
  {
    $composite_version = "archive/${version}.${version_minor}"
  }
  else
  {
    $composite_version = $version
  }

  if($python_version==undef)
  {
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
  }
  else
  {
    case $python_version
    {
      2:
      {
        $base_yum_repo = $saltstack::params::python2_base_repo
      }
      3:
      {
        $base_yum_repo = 'py3'
      }
      default:
      {
        fail("Unsupported python version; python_version can be either 2 or 3 - not ${python_version}")
      }
    }
  }

  case $facts['os']['family']
  {
    'redhat':
    {
      # [saltstack-repo]
      # name=SaltStack repo for RHEL/CentOS 7
      # baseurl=https://repo.saltstack.com/yum/redhat/7/$basearch/archive/3000.3
      # enabled=1
      # gpgcheck=1
      # gpgkey=https://repo.saltstack.com/yum/redhat/7/$basearch/archive/3000.3/SALTSTACK-GPG-KEY.pub

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
      # Run the following command to import the SaltStack repository key:
      # wget -O - https://repo.saltstack.com/apt/ubuntu/18.04/amd64/3000/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
      # Save the following file to /etc/apt/sources.list.d/saltstack.list:
      # deb http://repo.saltstack.com/apt/ubuntu/18.04/amd64/3000 bionic main

      apt::key { 'SALTSTACK-GPG-KEY':
        key        => 'C7A3D3EE96D9220BAE9420246DF2C88E747F3421',
        key_source => "${protocol}://repo.saltstack.com/${base_yum_repo}/${saltstack::params::repo_path}/amd64/${composite_version}/SALTSTACK-GPG-KEY.pub",
      }

      # deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main
      apt::source { 'saltstack':
        location => "${protocol}://repo.saltstack.com/${base_yum_repo}/${saltstack::params::repo_path}/amd64/${composite_version}",
        release  => $facts['os']['distro']['codename'],
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
