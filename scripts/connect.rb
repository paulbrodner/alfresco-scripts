require 'erubis'

module Install
  include DevOn
  
  Command.run_shell("ls -la")
  provision_on $config
end

