class saltstack::api::service inherits saltstack::api {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $saltstack::api::manage_docker_service)
  {
    if($saltstack::api::manage_service)
    {
      service { $saltstack::params::api_service_name:
        ensure     => $saltstack::api::service_ensure,
        enable     => $saltstack::api::service_enable,
        hasstatus  => true,
        hasrestart => true,
      }
    }
  }
}
