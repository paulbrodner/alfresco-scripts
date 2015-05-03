#
# Connection example script
#
module Install
  include DevOn

  if is_os OS_WIN
    Command.run_shell("echo 'aaaa'")
  else
    Command.run_shell("ls -la")
  end

  provision_on $config
end

