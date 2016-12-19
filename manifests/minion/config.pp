#
class saltstack::minion::config inherits saltstack::minion {
  #
  file { '/etc/salt/minion':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => "master: ${saltstack::minion::master}\n",
  }

  file { '/etc/salt/minion_id':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $saltstack::minion::minion_id,
  }

}
