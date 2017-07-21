class saltstack::params {

  $minion_package_name='salt-minion'
  $minion_service_name='salt-minion'

  $master_package_name='salt-master'
  $master_service_name='salt-master'

  case $::osfamily
  {
    'redhat':
    {
      $package_provider='rpm'
      $saltstack_repo_name='salt-repo'

      case $::operatingsystemrelease
      {
        /^6.*$/:
        {
          $saltstack_repo_url_key=undef
          $saltstack_repo_url_key_source=undef
          $saltstack_repo_url='https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el6.noarch.rpm'
        }
        /^7.*$/:
        {
          $saltstack_repo_url_key=undef
          $saltstack_repo_url_key_source=undef
          $saltstack_repo_url='https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm'
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
              $saltstack_repo_url_key='C7A3D3EE96D9220BAE9420246DF2C88E747F3421'
              $saltstack_repo_url_key_source='https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub'
              $saltstack_repo_url='http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest'
            }
            /^16.*$/:
            {
              $saltstack_repo_url_key='C7A3D3EE96D9220BAE9420246DF2C88E747F3421'
              $saltstack_repo_url_key_source='https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub'
              $saltstack_repo_url='http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest'
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
