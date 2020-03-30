class saltstack::master::service inherits saltstack::master {

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $saltstack::master::manage_docker_service)
  {
    if($saltstack::master::manage_service)
    {
      service { $saltstack::params::master_service_name:
        ensure => $saltstack::master::service_ensure,
        enable => $saltstack::master::service_enable,
      }
    }
  }

}
