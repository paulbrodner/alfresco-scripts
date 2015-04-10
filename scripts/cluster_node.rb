module ClusterNode
  include DevOn

  mysql = use_file($config, "mysql-connector-java-5.1.17-bin.jar")
  Command.upload_file(mysql, "#{$config.tomcat.lib}/mysql-connector-java-5.1.17-bin.jar")

  Command.run_shell "kill -9 $(ps aux | grep '[t]omcat' | awk '{print $2}')"

  global = use_file($config, "alfresco-global.properties.erb")
  Command.upload_file(global, "#{$config.tomcat.shared.classes.home}/alfresco-global.properties")

  Command.upload_file(use_file($config, "ctl.sh"), "#{$config.tomcat.scripts}/ctl.sh")

  #disable ssl
  Command.upload_file(use_file($config, "server.xml.erb"), "#{$config.tomcat.conf}/server.xml")
  Command.upload_file(use_file($config, "tomcat-users.xml"), "#{$config.tomcat.conf}/tomcat-users.xml")
  Command.upload_file(use_file($config, "web.xml"), "#{$config.tomcat.webapps.alfresco.web_inf}/web.xml")
  #disable ssl

  #CLUSTER settings
  #Initiating clustering: http://docs.alfresco.com/4.1/tasks/jgroups-repo.html
  Command.upload_file(use_file($config, "ehcache-custom.xml"), "#{$config.tomcat.shared.classes.alfresco_extension}/ehcache-custom.xml")
  Command.upload_file(use_file($config, "custom-cache-context.xml"), "#{$config.tomcat.shared.classes.alfresco_extension}/custom-cache-context.xml")
  Command.upload_file(use_file($config, "disable-transformers-context.xml"), "#{$config.tomcat.shared.classes.alfresco_extension}/disable-transformers-context.xml")

  #hazelcast share: http://docs.alfresco.com/4.1/concepts/hazelcast-cluster-share.html
  Command.upload_file(use_file($config, "custom-slingshot-application-context.xml.erb"), "#{$config.tomcat.shared.classes.alfresco_web_extension}/custom-slingshot-application-context.xml")
  #CLUSTER settings

  #clean alfresco.log
  Command.run_shell "cd /home/bm0013/alfresco-4.1.10 && cat /dev/null > alfresco.log"

  #start server
  Command.run_shell "cd /home/bm0013/alfresco-4.1.10 && ./alfresco.sh start"
  provision_on $config
end
