require 'erubis'

module Install
  include DevOn

  Command.run_shell "kill -9 $(ps aux | grep '[t]omcat' | awk '{print $2}')"

  #start server
  Command.run_shell "cd #{$config.alfresco.home} && ./alfresco.sh start"

  provision_on $config
end

