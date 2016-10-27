class saltstack::params {

  case $::osfamily
  {
    'redhat':
    {
      $package_provider='rpm'

      case $::operatingsystemrelease
      {
        /^5.*$/:
        {
          $saltstack_repo_url="https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el5.noarch.rpm"
        }
        /^6.*$/:
        {
          $saltstack_repo_url="https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el6.noarch.rpm"
        }
        /^7.*$/:
        {
          $saltstack_repo_url="https://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el7.noarch.rpm"
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              fail('currently unsupported - fuck off')
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
