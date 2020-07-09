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


  case $facts['os']['family']
  {
    'redhat':
    {
      $package_provider='rpm'
      $saltstack_repo_name='salt-repo'
      $saltstack_repo_url_key=undef

      case $facts['os']['release']['full']
      {
        /^[56].*$/:
        {
          $api_dependencies=undef
          $windows_dependencies=undef
          $base_repo = 'yum'
        }
        /^7.*$/:
        {
          $api_dependencies=['pyOpenSSL']
          $windows_dependencies=[ 'python2-impacket', 'python2-winrm' ]
          $base_repo = 'yum'
        }
        /^8.*$/:
        {
          $api_dependencies=['pyOpenSSL']
          $windows_dependencies=[ 'python2-impacket', 'python2-winrm' ]
          $base_repo = 'py3'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${facts['os']['release']['full']}")  }
      }
    }
    'Debian':
    {
      $base_repo = undef
      $package_provider=undef
      $saltstack_repo_name=undef
      $saltstack_repo_url_key='C7A3D3EE96D9220BAE9420246DF2C88E747F3421'

      $api_dependencies=undef
      $windows_dependencies=[ 'python-impacket', 'python-winrm' ]

      case $facts['os']['name']
      {
        'Ubuntu':
        {
          case $facts['os']['release']['full']
          {
            /^1[468].*$/:
            {
            }
            /^20.*$/:
            {
            }
            default: { fail("Unsupported Ubuntu version! - ${facts['os']['release']['full']}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
