class saltstack::service inherits saltstack {

  #
  validate_bool($saltstack::manage_docker_service)
  validate_bool($saltstack::manage_service)
  validate_bool($saltstack::service_enable)

  validate_re($saltstack::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${saltstack::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  # if( $is_docker_container==false or
  #     $saltstack::manage_docker_service)
  # {
  #   if($saltstack::manage_service)
  #   {
  #     #service or exec here
  #   }
  # }
}
