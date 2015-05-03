# restart alfresco tomcat server
# kills postgres sql too
#
module Install
  include DevOn

  Command.kill_program "tomcat"
  Command.kill_program "postgres"

  #clean alfresco.log
  Command.run_shell "cd #{$config.alfresco.home} && cat /dev/null > alfresco.log"

  #start server
  Command.run_shell "cd #{$config.alfresco.home} && ./alfresco.sh start"

  provision_on $config
end

