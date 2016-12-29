class saltstack::master::service inherits saltstack::master {
  #
  validate_bool($saltstack::master::manage_docker_service)
  validate_bool($saltstack::master::manage_service)
  validate_bool($saltstack::master::service_enable)

  validate_re($saltstack::master::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${saltstack::master::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $saltstack::master::manage_docker_service)
  {
    if($saltstack::master::manage_service)
    {
      service { $saltstack::params::master_service_name:
        ensure => $saltstack::master::service_enable,
        enable => $saltstack::master::service_enable,
      }
    }
  }

}
