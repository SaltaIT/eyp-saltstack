define saltstack::minion::grain (
                                  $grain_name = $name,
                                  $value = undef,
                                  $order = '00',
                                ) {
    include ::saltstack::minion

    if(!defined(Concat::Fragment['salt minion grains base']))
    {
      concat::fragment{ 'salt minion grains base':
        target  => '/etc/salt/minion',
        order   => '01a',
        content => "grains:\n",
      }
    }

    concat::fragment{ "salt minion grains $salt minion grain ${grain_name}":
      target  => '/etc/salt/minion',
      order   => "01b-${order}",
      content => template("${module_name}/minion/grain.erb"),
      require => Concat::Fragment['salt minion grains base'],
    }

}
