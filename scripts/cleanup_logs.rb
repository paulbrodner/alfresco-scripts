#
# creates a backup copy of alfresco.log, solr.log and catalina.out
# and it will empty those files
# Solr,Alfresco, Tomcat on the same node.
module CleanUpLogs
  include DevOn

  Command.run_shell("ls #{$config.alfresco.home}/*.log*")
  logs = provision_on $config

  logs.each do | log|
    Command.backup log
    Command.run_shell "cat /dev/null > #{log}"
  end

  Command.run_shell("ls #{$config.tomcat.home}/logs/*.log*")
  logsTomcat = provision_on $config

  logsTomcat.each do | log|
    Command.backup log
    Command.run_shell "cat /dev/null > #{log}"
  end

  provision_on $config
end
