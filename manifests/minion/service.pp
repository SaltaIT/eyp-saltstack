class saltstack::minion::service inherits saltstack::minion {
  #
  validate_bool($saltstack::minion::manage_docker_service)
  validate_bool($saltstack::minion::manage_service)
  validate_bool($saltstack::minion::service_enable)

  validate_re($saltstack::minion::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${saltstack::minion::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $saltstack::minion::manage_docker_service)
  {
    if($saltstack::minion::manage_service)
    {
      service { $saltstack::params::minion_service_name:
        ensure => $saltstack::minion::service_ensure,
        enable => $saltstack::minion::service_enable,
      }
    }
  }

}
