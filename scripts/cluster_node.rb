module ClusterNode
  include DevOn

  mysql = use_file($config, "mysql-connector-java-5.1.17-bin.jar")
  Command.upload_file(mysql, "/home/bm0013/alfresco-4.1.10/tomcat/lib/mysql-connector-java-5.1.17-bin.jar")

  Command.run_shell "kill -9 $(ps aux | grep '[t]omcat' | awk '{print $2}')"

  global = use_file($config, "alfresco-global.properties.erb")
  Command.upload_file(global, "/home/bm0013/alfresco-4.1.10/tomcat/shared/classes/alfresco-global.properties")

  #disable ssl
  Command.upload_file(use_file($config, "server.xml.erb"), "/home/bm0013/alfresco-4.1.10/tomcat/conf/server.xml")
  Command.upload_file(use_file($config, "tomcat-users.xml"), "/home/bm0013/alfresco-4.1.10/tomcat/conf/tomcat-users.xml")
  Command.upload_file(use_file($config, "web.xml"), "/home/bm0013/alfresco-4.1.10/tomcat/webapps/alfresco/WEB-INF/web.xml")
  #disable ssl

  #CLUSTER settings
  #Initiating clustering: http://docs.alfresco.com/4.1/tasks/jgroups-repo.html
  Command.upload_file(use_file($config, "ehcache-custom.xml"), "/home/bm0013/alfresco-4.1.10/tomcat/shared/classes/alfresco/extension/ehcache-custom.xml")
  Command.upload_file(use_file($config, "custom-cache-context.xml"), "/home/bm0013/alfresco-4.1.10/tomcat/shared/classes/alfresco/extension/custom-cache-context.xml")
  Command.upload_file(use_file($config, "disable-transformers-context.xml"), "/home/bm0013/alfresco-4.1.10/tomcat/shared/classes/alfresco/extension/disable-transformers-context.xml")

  #hazelcast share: http://docs.alfresco.com/4.1/concepts/hazelcast-cluster-share.html
  Command.upload_file(use_file($config, "custom-slingshot-application-context.xml.erb"), "/home/bm0013/alfresco-4.1.10/tomcat/shared/classes/alfresco/web-extension/custom-slingshot-application-context.xml")
  #CLUSTER settings

  #clean alfresco.log
  Command.run_shell "cd /home/bm0013/alfresco-4.1.10 && cat /dev/null > alfresco.log"

  #start server
  Command.run_shell "cd /home/bm0013/alfresco-4.1.10 && ./alfresco.sh start"
  provision_on $config
end
