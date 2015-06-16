#
# update a node to be a cluster alfresco node.
# using:
#   mysql as connector
#   tomcat tunned up for performance
#   disabled secure communication with solr
#   enable cluster 
#   adding hazelcast
# !Start Alfresco first, to create the web app
#
module ClusterNode
  include DevOn

  #Command.run_shell "cd #{$config.alfresco.home} && ./alfresco.sh start"
  Command.kill_program "tomcat"

  # upload mysql conector
  Command.upload_file(use_file($config, "mysql-connector-java-5.1.17-bin.jar"), "#{$config.tomcat.lib}/mysql-connector-java-5.1.17-bin.jar")

  # upload
  Command.upload_file(use_file($config, "alfresco-global.properties.erb"), "#{$config.tomcat.shared.classes.home}/alfresco-global.properties")

  #logs
  Command.upload_file(use_file($config, "log4j.properties"), $config.tomcat.webapps.alfresco.classes.log4j)

  #remove solr4
  Command.run_shell "rm -rf #{$config.tomcat.webapps.solr4}"
  Command.run_shell "rm -f #{$config.tomcat.webapps.solr4war}"

  # add license
  Command.run_shell "mkdir #{$config.tomcat.shared.classes.alfresco_license}"
  Command.upload_file(use_file($config, "ravi-all enabled.lic"), "#{$config.alfresco.home}/ravi-all enabled.lic")

  # tomcat cfg  
  Command.upload_file(use_file($config, "ctl.sh.erb"), "#{$config.tomcat.scripts}/ctl.sh")
  # tomcat disable ssl
  Command.upload_file(use_file($config, "server.xml.erb"), "#{$config.tomcat.conf}/server.xml")
  Command.upload_file(use_file($config, "tomcat-users.xml"), "#{$config.tomcat.conf}/tomcat-users.xml")
  Command.upload_file(use_file($config, "web.xml"), "#{$config.tomcat.webapps.alfresco.web_inf}/web.xml")

  #CLUSTER HAZELCAST settings
  Command.upload_file(use_file($config, "custom-slingshot-application-context.xml.erb"), "#{$config.tomcat.shared.classes.alfresco_web_extension}/custom-slingshot-application-context.xml")

  #clean alfresco.log
  Command.run_shell "cd #{$config.alfresco.home} && cat /dev/null > alfresco.log"

  Command.ask_permision do
    #start server
    Command.run_shell "cd #{$config.alfresco.home} && ./alfresco.sh start"
  end

  provision_on $config
end
