class saltstack::api(
                      $manage_package           = true,
                      $package_ensure           = 'installed',
                      $manage_service           = true,
                      $manage_docker_service    = true,
                      $service_ensure           = 'running',
                      $service_enable           = true,
                      $port                     = '8000',
                      $host                     = undef,
                      $debug                    = false,
                      $ssl_crt                  = undef,
                      $ssl_key                  = undef,
                      $disable_ssl              = undef,
                      $webhook_disable_auth     = false,
                      $webhook_url              = undef,
                      $thread_pool              = '100',
                      $socket_queue_size        = '30',
                      $expire_responses         = false,
                      $max_request_body_size    = '1048576',
                      $collect_stats            = false,
                      $static                   = undef,
                      $static_path              = undef,
                      $app                      = undef,
                      $app_path                 = undef,
                      $root_prefix              = '/',
                      $generate_selfsigned_cert = true,
                      $rest_timeout             = '7200',
                    ) inherits saltstack::params {

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^6.*$/: { fail("api is not unsupported for this OS - ${::osfamily}/${::operatingsystemrelease}") }
        /^7.*$/: { }
        default: { }
      }
    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/: { fail("api is not unsupported for this OS - ${::osfamily}/${::operatingsystemrelease}") }
            /^16.*$/: { }
            /^18.*$/: { }
            default: { }
          }
        }
        default: { }
      }
    }
    default: { }
  }

  include ::saltstack::master

  Class['::saltstack::master'] ->
  class { '::saltstack::api::install': } ->
  class { '::saltstack::api::config': } ~>
  class { '::saltstack::api::service': } ->
  Class['::saltstack::api']
}
