require 'erubis'

module Install
  include DevOn

  Command.run_shell "kill -9 $(ps aux | grep '[t]omcat' | awk '{print $2}')"

  #start server
  Command.run_shell "cd /home/bm0013/alfresco-4.1.10 && ./alfresco.sh start"

  provision_on $config
end

