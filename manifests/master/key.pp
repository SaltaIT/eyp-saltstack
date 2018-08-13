define saltstack::master::key (
                                $hostname = $name,
                                $status   = 'accepted',
                              ) {
  $current_status = salt_key_status($hostname)

  case $status
  {
    'accepted':
    {
      fail($current_status)
    }
    default: { fail('Unsupported status') }
  }
}
