Puppet::Functions.create_function(:salt_key_status) do |args|
  dispatch :salt_key_status do
    param 'String', :arg
  end

  def salt_key_status(arg)
    # salt-key -L --out=txt | grep "'centos7.vm'" | cut -f 1 -d:
    command = ['/usr/bin/salt-key -L --out=txt | grep']
    command.push("\"'" + arg + "'\"")
    command.push("| cut -f 1 -d:")

    command = command.join ' '

    output = Puppet::Util::Execution.execute(command, {
      :uid                => 'root',
      :gid                => 'root',
      :failonfail         => false,
      :combine            => true,
      :override_locale    => true,
    })

    return output
  end

end
