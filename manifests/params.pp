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
        /^5.*$/:
        {
          $api_dependencies=undef
          $saltstack_repo_url_key_source=undef
          $saltstack_repo_url = {
                                  'latest' => '://repo.saltstack.com/yum/redhat/salt-repo-latest-1.el5.noarch.rpm',
                                  '2015.5' => '://repo.saltstack.com/yum/redhat/salt-repo-2015.5-1.el5.noarch.rpm',
                                  '2015.8' => '://repo.saltstack.com/yum/redhat/salt-repo-2015.8-3.el5.noarch.rpm',
                                  '2016.11' => '://repo.saltstack.com/yum/redhat/salt-repo-2016.11-1.el5.noarch.rpm',
                                  '2016.3' => '://repo.saltstack.com/yum/redhat/salt-repo-2016.3-1.el5.noarch.rpm',
                                }

          $windows_dependencies=undef
        }
        /^6.*$/:
        {
          $api_dependencies=undef
          $saltstack_repo_url_key_source=undef
          $saltstack_repo_url = {
                                  'latest' => '://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el6.noarch.rpm',
                                  '2018.3' => '://repo.saltstack.com/yum/redhat/salt-repo-2018.3-1.el6.noarch.rpm',
                                  '2017.7' => '://repo.saltstack.com/yum/redhat/salt-repo-2017.7-1.el6.noarch.rpm',
                                  '2016.11' => '://repo.saltstack.com/yum/redhat/salt-repo-2016.11-2.el6.noarch.rpm',
                                  '2016.3' => '://repo.saltstack.com/yum/redhat/salt-repo-2016.3-2.el6.noarch.rpm',
                                  '2019.2' => '://repo.saltstack.com/yum/redhat/salt-repo-2019.2.el6.noarch.rpm',
                                }

          $windows_dependencies=undef
        }
        /^7.*$/:
        {
          $api_dependencies=['pyOpenSSL']
          $saltstack_repo_url_key_source=undef
          $saltstack_repo_url = {
                                  'latest' => '://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm',
                                  '2018.3' => '://repo.saltstack.com/yum/redhat/salt-repo-2018.3-1.el7.noarch.rpm',
                                  '2017.7' => '://repo.saltstack.com/yum/redhat/salt-repo-2017.7-1.el7.noarch.rpm',
                                  '2016.11' => '://repo.saltstack.com/yum/redhat/salt-repo-2016.11-2.el7.noarch.rpm',
                                  '2016.3' => '://repo.saltstack.com/yum/redhat/salt-repo-2016.3-2.el7.noarch.rpm',
                                  '2019.2' => '://repo.saltstack.com/yum/redhat/salt-repo-2019.2.el7.noarch.rpm',
                                }

          $windows_dependencies=[ 'python2-impacket', 'python2-winrm' ]
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $package_provider=undef
      $saltstack_repo_name=undef
      $saltstack_repo_url_key='C7A3D3EE96D9220BAE9420246DF2C88E747F3421'

      $api_dependencies=undef
      $windows_dependencies=[ 'python-impacket', 'python-winrm' ]

      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $saltstack_repo_url_key_source= {
                                                'latest' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub',
                                                '2018.3' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/2018.3/SALTSTACK-GPG-KEY.pub',
                                                '2017.7' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/2017.7/SALTSTACK-GPG-KEY.pub',
                                                '2016.11' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/2016.11/SALTSTACK-GPG-KEY.pub',
                                                '2016.3' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/2016.3/SALTSTACK-GPG-KEY.pub',
                                              }
              $saltstack_repo_url = {
                                      'latest' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest',
                                      '2018.3' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/2018.3',
                                      '2017.7' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/2017.7',
                                      '2016.11' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/2016.11',
                                      '2016.3' => '://repo.saltstack.com/apt/ubuntu/14.04/amd64/2016.3',
                                    }
            }
            /^16.*$/:
            {
              $saltstack_repo_url_key_source= {
                                                'latest' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub',
                                                '2018.3' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/2018.3/SALTSTACK-GPG-KEY.pub',
                                                '2017.7' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/2017.7/SALTSTACK-GPG-KEY.pub',
                                                '2016.11' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/2016.11/SALTSTACK-GPG-KEY.pub',
                                                '2016.3' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/2016.3/SALTSTACK-GPG-KEY.pub',
                                              }
              $saltstack_repo_url = {
                                      'latest' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest',
                                      '2018.3' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/2018.3',
                                      '2017.7' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/2017.7',
                                      '2016.11' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/2016.11',
                                      '2016.3' => '://repo.saltstack.com/apt/ubuntu/16.04/amd64/2016.3',
                                    }
            }
            /^18.*$/:
            {
              $saltstack_repo_url_key_source= {
                                                'latest' => '://repo.saltstack.com/apt/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub',
                                                '2018.3' => '://repo.saltstack.com/apt/ubuntu/18.04/amd64/2018.3/SALTSTACK-GPG-KEY.pub',
                                                '2017.7' => '://repo.saltstack.com/apt/ubuntu/18.04/amd64/2017.7/SALTSTACK-GPG-KEY.pub',
                                              }
              $saltstack_repo_url = {
                                      'latest' => '://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest',
                                      '2018.3' => '://repo.saltstack.com/apt/ubuntu/18.04/amd64/2018.3',
                                      '2017.7' => '://repo.saltstack.com/apt/ubuntu/18.04/amd64/2017.7',
                                    }
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    'Suse':
    {
      $package_provider=undef
      $saltstack_repo_name='systemsmanagement_saltstack_products'
      $saltstack_repo_url_key=undef

      case $::operatingsystem
      {
        'SLES':
        {
          case $::operatingsystemrelease
          {
            '11.3':
            {
              $saltstack_repo_url_key_source= undef
              $saltstack_repo_url = {
                                      'latest' => '://repo.saltstack.com/opensuse/SLE_11_SP3/systemsmanagement:saltstack:products.repo',
                                    }
            }
            '12.3':
            {
              $saltstack_repo_url_key_source= undef
              $saltstack_repo_url = {
                                      'latest' => '://repo.saltstack.com/opensuse/SLE_12_SP3/systemsmanagement:saltstack:products.repo',
                                    }
            }
            default: { fail("Unsupported SLES version! - ${::operatingsystemrelease}")  }
          }
        }
        default: { fail("Unsupported SuSE version! - ${::operatingsystemrelease}")  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
