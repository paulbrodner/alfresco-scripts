# restart alfresco tomcat server
module HarvestLogs
  include DevOn

  Command.run_shell "cd #{$config.alfresco.home} && cp alfresco.log{,.bkp}"
  Command.run_shell "cd #{$config.alfresco.home} && cat /dev/null > alfresco.log"
  
  
  Command.run_shell "cd #{$config.tomcat.home}/logs && cp catalina.out{,.bkp}"
  Command.run_shell "cd #{$config.tomcat.home}/logs && cat /dev/null > catalina.out"
 
  provision_on $config
end
