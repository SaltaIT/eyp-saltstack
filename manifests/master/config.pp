#
class saltstack::master::config inherits saltstack::master {
  #
  file { '/etc/salt/master':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/master/master.erb"),
  }
}
