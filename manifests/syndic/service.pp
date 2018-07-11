class saltstack::syndic::service inherits saltstack::syndic {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $saltstack::syndic::manage_docker_service)
  {
    if($saltstack::syndic::manage_service)
    {
      service { $saltstack::params::syndic_service_name:
        ensure     => $saltstack::syndic::service_ensure,
        enable     => $saltstack::syndic::service_enable,
        hasstatus  => true,
        hasrestart => true,
      }
    }
  }
}
