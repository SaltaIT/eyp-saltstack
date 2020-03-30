class saltstack::minion::service inherits saltstack::minion {

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
