class saltstack::params {

  $minion_package_name='salt-minion'
  $minion_service_name='salt-minion'

  $master_package_name='salt-master'
  $master_service_name='salt-master'

  $api_package_name='salt-api'
  $api_service_name='salt-api'

  $syndic_package_name='salt-syndic'
  $syndic_service_name='salt-syndic'

  $cloud_package_name='salt-cloud'

  $ssh_package_name = 'salt-ssh'


  case $::osfamily
  {
    'redhat':
    {
      $package_provider='rpm'
      $saltstack_repo_name='salt-repo'
      $saltstack_repo_url_key=undef

      case $::operatingsystemrelease
      {
        /^6.*$/:
        {
          $api_dependencies=undef
          $saltstack_repo_url_key_source=undef
          $saltstack_repo_url='https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el6.noarch.rpm'

          $windows_dependencies=undef
        }
        /^7.*$/:
        {
          $api_dependencies=['pyOpenSSL']
          $saltstack_repo_url_key_source=undef
          $saltstack_repo_url='https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm'

          $windows_dependencies=[ 'python2-impacket', 'python2-winrm' ]
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $api_dependencies=undef
      $windows_dependencies=[ 'python-impacket', 'python-winrm' ]

      case $::operatingsystem
      {
        'Ubuntu':
        {
          $saltstack_repo_url_key='C7A3D3EE96D9220BAE9420246DF2C88E747F3421'
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $saltstack_repo_url_key_source='https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub'
              $saltstack_repo_url='http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest'
            }
            /^16.*$/:
            {
              $saltstack_repo_url_key_source='https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub'
              $saltstack_repo_url='http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest'
            }
            /^18.*$/:
            {
              $saltstack_repo_url_key_source='https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub'
              $saltstack_repo_url='http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest'
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
