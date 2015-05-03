#
# creates a backup copy of alfresco.log, solr.log and catalina.out
# and it will empty those files
# Solr,Alfresco, Tomcat on the same node.
module CleanUpLogs
  include DevOn

  Command.backup "#{$config.alfresco.home}/alfresco.log"
  Command.run_shell "cd #{$config.alfresco.home} && cat /dev/null > alfresco.log"

  Command.backup "#{$config.alfresco.home}/solr.log"
  Command.run_shell "cd #{$config.alfresco.home} && cat /dev/null > solr.log"

  Command.backup "#{$config.tomcat.home}/catalina.out"
  Command.run_shell "cd #{$config.tomcat.home}/logs && cat /dev/null > catalina.out"

  provision_on $config
end
