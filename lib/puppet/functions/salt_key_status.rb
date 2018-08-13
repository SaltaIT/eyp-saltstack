Puppet::Parser::Functions::newfunction(:salt_key_status, :type => :rvalue, :doc => <<-EOS
Get salt key current status
EOS
) do |args|
  raise(Puppet::ParseError, "salt_key_status() wrong number of arguments. #{args.size} vs 1)") if args.size != 1

  arg = args[0]

  # salt-key -L --out=txt | grep "'centos7.vm'" | cut -f 1 -d:

  command = ['/usr/bin/salt-key -L --out=txt | grep']
  command.push("\"'" + arg + "'\"")
  command.push("| cut -f 1 -d:")

  command = command.join ' '

  output = Puppet::Util::Execution.execute(command, {
    :uid                => resource[:atom_user],
    :gid                => 'root',
    :failonfail         => false,
    :combine            => true,
    :override_locale    => true,
  })

  return output

end
