# restart alfresco tomcat server
# kills postgres sql too
#
module Install
  include DevOn

  Command.run_shell "kill -9 $(ps aux | grep '[t]omcat' | awk '{print $2}')"

  Command.run_shell "kill -9 $(ps aux | grep '[p]ostgres' | awk '{print $2}')"

  #clean alfresco.log
  Command.run_shell "cd #{$config.alfresco.home} && cat /dev/null > alfresco.log"

  #start server
  Command.run_shell "cd #{$config.alfresco.home} && ./alfresco.sh start"

  provision_on $config
end

