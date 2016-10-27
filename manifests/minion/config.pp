class saltstack::minion::config inherits saltstack::minion {
  file { '/etc/salt/minion':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => "master: ${saltstack::master}\n",
  }
}
