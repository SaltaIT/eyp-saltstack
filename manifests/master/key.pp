# [root@centos7 ~]# salt-key -L --out=txt
# minions_rejected: []
# minions_denied: []
# minions_pre: [u'centos7.vm']
# minions: [u'centos71.vm']
define saltstack::master::key (
                                $hostname = $name,
                                $status   = 'accepted',
                              ) {
  include ::saltstack::master
  
  $current_status = salt_key_status($hostname)

  case $status
  {
    'accepted':
    {
      case $current_status
      {
        /^minions$/: {}
        /^minions_/:
        {
          exec { "salt-key for ${hostname} from ${current_status} to ${status}":
            command => "salt-key -a ${hostname} --include-rejected --include-denied -y",
            path    => '/usr/sbin:/usr/bin:/sbin:/bin',
          }
        }
        default: { fail("ERROR: current status set as '${current_status}' - desired state: ${status}")}
      }
    }
    'rejected':
    {
      case $current_status
      {
        /^minions_denied$/, /^minions$/, /^minions_pre$/:
        {
          exec { "salt-key for ${hostname} from ${current_status} to ${status}":
            command => "salt-key -r ${hostname} --include-accepted --include-denied -y",
            path    => '/usr/sbin:/usr/bin:/sbin:/bin',
          }
        }
        /^minions_rejected$/: { }
        default: { fail("ERROR: current status set as '${current_status}' - desired state: ${status}")}
      }
    }
    default: { fail("Unsupported desired status: ${status}") }
  }
}
