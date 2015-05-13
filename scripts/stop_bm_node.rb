#
# kills alfresco tomcat server
# kills postgres sql too
#
module Install
  include DevOn

  Command.kill_program "tomcat"
  Command.kill_program "postgres"

  provision_on $config
end

