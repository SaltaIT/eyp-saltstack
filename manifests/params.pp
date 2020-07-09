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

      $python2_base_repo = 'yum'
      $repo_path = undef

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
      $package_provider=undef
      $saltstack_repo_name=undef
      $saltstack_repo_url_key='C7A3D3EE96D9220BAE9420246DF2C88E747F3421'

      $api_dependencies=undef
      $windows_dependencies=[ 'python-impacket', 'python-winrm' ]

      $python2_base_repo = 'apt'

      case $facts['os']['name']
      {
        'Ubuntu':
        {
          case $facts['os']['release']['full']
          {
            /^14.*$/:
            {
              $repo_path = 'ubuntu/14.04'
              $base_repo = 'apt'
            }
            /^16.*$/:
            {
              $repo_path = 'ubuntu/16.04'
              $base_repo = 'apt'
            }
            /^18.*$/:
            {
              $repo_path = 'ubuntu/18.04'
              $base_repo = 'apt'
            }
            /^20.*$/:
            {
              $repo_path = 'ubuntu/20.04'
              $base_repo = 'py3'
            }
            default: { fail("Unsupported Ubuntu version! - ${facts['os']['release']['full']}")  }
          }
        }
        'Debian':
        {
          case $facts['os']['release']['major']
          {
            8:
            {
              $repo_path = 'debian/8'
              $base_repo = 'apt'
            }
            9:
            {
              $repo_path = 'debian/9'
              $base_repo = 'apt'
            }
            10:
            {
              $repo_path = 'debian/10'
              $base_repo = 'py3'
            }
            default: { fail("Unsupported Debian version! - ${facts['os']['release']['full']}")  }
          }
        }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
